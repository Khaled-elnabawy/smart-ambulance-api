<?php namespace App\Http\Controllers\Api\V1; use App\Http\Controllers\Controller; use App\Http\Requests\Api\V1\StoreRequestRequest; use App\Models\Driver; use Illuminate\Support\Facades\DB; use Illuminate\Http\Response;

class RequestController extends Controller
{
    /**
     * Create a new request
     * POST /api/v1/requests
     */
    public function store(StoreRequestRequest $request)
    {
        $user = $request->user();

        // Authorization: Only Users can create requests
        if ($user instanceof Driver) {
            return response()->json([
                'status' => false,
                'message' => 'Only users can create requests',
            ], Response::HTTP_FORBIDDEN);
        }

        try {
            $validated = $request->validated();

            $createdRequest = DB::transaction(function () use ($validated, $user) {
                $requestData = [
                    'user_id' => $user->id,
                    'request_type' => $validated['request_type'],
                    'status' => 'pending',
                    'pickup_latitude' => $validated['pickup_latitude'],
                    'pickup_longitude' => $validated['pickup_longitude'],
                    'scheduled_time' => $validated['scheduled_time'] ?? null,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];

                $newRequestId = DB::table('requests')->insertGetId($requestData);

                DB::table('request_history')->insert([
                    'request_id' => $newRequestId,
                    'action' => 'Request Created',
                    'actor_type' => 'user',
                    'actor_id' => $user->id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                // PHASE 1: Automatic Driver Assignment
                $this->assignAvailableDriver($newRequestId);

                return DB::table('requests')->where('id', $newRequestId)->first();
            });

            return response()->json([
                'status' => true,
                'message' => 'Request created successfully',
                'data' => $createdRequest,
            ], Response::HTTP_CREATED);

        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Failed to create request',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Driver Accept Request
     * POST /api/v1/requests/{id}/accept
     */
    public function accept($id)
    {
        $driver = auth()->user();

        // Ensure only drivers can accept
        if (!$driver instanceof Driver) {
            return response()->json([
                'status' => false,
                'message' => 'Only drivers can accept requests',
            ], Response::HTTP_FORBIDDEN);
        }

        try {
            $result = DB::transaction(function () use ($id, $driver) {
                // Get request with lock to prevent race conditions
                $request = DB::table('requests')
                    ->where('id', $id)
                    ->lockForUpdate()
                    ->first();

                if (!$request) {
                    return ['status' => false, 'message' => 'Request not found', 'code' => Response::HTTP_NOT_FOUND];
                }

                // Verify driver is assigned to this request
                if ($request->driver_id != $driver->id) {
                    return ['status' => false, 'message' => 'You are not assigned to this request', 'code' => Response::HTTP_FORBIDDEN];
                }

                // Verify request is pending
                if ($request->status !== 'pending') {
                    return ['status' => false, 'message' => 'Request is not pending', 'code' => Response::HTTP_BAD_REQUEST];
                }

                // Verify driver is available (lock driver record to prevent race conditions)
                $driverRecord = DB::table('drivers')
                    ->where('id', $driver->id)
                    ->lockForUpdate()
                    ->first();

                if (!$driverRecord || $driverRecord->status !== 'available') {
                    return ['status' => false, 'message' => 'Driver is not available', 'code' => Response::HTTP_BAD_REQUEST];
                }

                // Update request status to accepted
                $updated = DB::table('requests')
                    ->where('id', $id)
                    ->where('status', 'pending')
                    ->update([
                        'status' => 'accepted',
                        'updated_at' => now(),
                    ]);

                if ($updated === 0) {
                    return [
                        'status' => false,
                        'message' => 'Request already accepted or not pending',
                        'code' => Response::HTTP_BAD_REQUEST
                    ];
                }

                // Update driver status to busy
                DB::table('drivers')
                    ->where('id', $driver->id)
                    ->update([
                        'status' => 'busy',
                        'updated_at' => now(),
                    ]);

                // Log action
                DB::table('request_history')->insert([
                    'request_id' => $id,
                    'action' => 'Driver Accepted',
                    'actor_type' => 'driver',
                    'actor_id' => $driver->id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                return ['status' => true, 'request' => DB::table('requests')->where('id', $id)->first()];
            });

            if (!$result['status']) {
                return response()->json([
                    'status' => false,
                    'message' => $result['message'],
                ], $result['code']);
            }

            return response()->json([
                'status' => true,
                'message' => 'Request accepted',
                'data' => $result['request'],
            ], Response::HTTP_OK);

        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Failed to accept request',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Driver Reject Request
     * POST /api/v1/requests/{id}/reject
     */
    public function reject($id)
    {
        $driver = auth()->user();

        // Ensure only drivers can reject
        if (!$driver instanceof Driver) {
            return response()->json([
                'status' => false,
                'message' => 'Only drivers can reject requests',
            ], Response::HTTP_FORBIDDEN);
        }

        try {
            $result = DB::transaction(function () use ($id, $driver) {
                // Get request with lock
                $request = DB::table('requests')
                    ->where('id', $id)
                    ->lockForUpdate()
                    ->first();

                if (!$request) {
                    return ['status' => false, 'message' => 'Request not found', 'code' => Response::HTTP_NOT_FOUND];
                }

                // Verify driver is assigned
                if ($request->driver_id != $driver->id) {
                    return ['status' => false, 'message' => 'You are not assigned to this request', 'code' => Response::HTTP_FORBIDDEN];
                }

                // Verify request is pending
                if ($request->status !== 'pending') {
                    return ['status' => false, 'message' => 'Request is not pending', 'code' => Response::HTTP_BAD_REQUEST];
                }

                // Update request: remove driver assignment
                DB::table('requests')
                    ->where('id', $id)
                    ->update([
                        'driver_id' => null,
                        'updated_at' => now(),
                    ]);

                // Update driver status back to available
                DB::table('drivers')
                    ->where('id', $driver->id)
                    ->update(['status' => 'available']);

                // Log rejection
                DB::table('request_history')->insert([
                    'request_id' => $id,
                    'action' => 'Driver Rejected',
                    'actor_type' => 'driver',
                    'actor_id' => $driver->id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                // Re-run assignment logic to assign next available driver
                $this->assignAvailableDriver($id, $driver->id);

                return ['status' => true, 'request' => DB::table('requests')->where('id', $id)->first()];
            });

            if (!$result['status']) {
                return response()->json([
                    'status' => false,
                    'message' => $result['message'],
                ], $result['code']);
            }

            return response()->json([
                'status' => true,
                'message' => 'Request rejected',
                'data' => $result['request'],
            ], Response::HTTP_OK);

        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Failed to reject request',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Driver Arrived at Pickup Location
     * POST /api/v1/requests/{id}/arrived
     */
    public function arrived($id)
    {
        $driver = auth()->user();

        if (!$driver instanceof Driver) {
            return response()->json([
                'status' => false,
                'message' => 'Only drivers can update request status',
            ], Response::HTTP_FORBIDDEN);
        }

        try {
            $result = DB::transaction(function () use ($id, $driver) {
                $request = DB::table('requests')
                    ->where('id', $id)
                    ->lockForUpdate()
                    ->first();

                if (!$request) {
                    return ['status' => false, 'message' => 'Request not found', 'code' => Response::HTTP_NOT_FOUND];
                }

                if ($request->driver_id != $driver->id) {
                    return ['status' => false, 'message' => 'You are not assigned to this request', 'code' => Response::HTTP_FORBIDDEN];
                }

                // Verify transition: accepted → arrived
                if ($request->status !== 'accepted') {
                    return ['status' => false, 'message' => 'Request must be in_progress to mark as arrived', 'code' => Response::HTTP_BAD_REQUEST];
                }

                // Update status
                DB::table('requests')
                    ->where('id', $id)
                    ->update([
                        'status' => 'arrived',
                        'updated_at' => now(),
                    ]);

                // Log action
                DB::table('request_history')->insert([
                    'request_id' => $id,
                    'action' => 'Driver Arrived',
                    'actor_type' => 'driver',
                    'actor_id' => $driver->id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                return ['status' => true, 'request' => DB::table('requests')->where('id', $id)->first()];
            });

            if (!$result['status']) {
                return response()->json([
                    'status' => false,
                    'message' => $result['message'],
                ], $result['code']);
            }

            return response()->json([
                'status' => true,
                'message' => 'Request updated: arrived',
                'data' => $result['request'],
            ], Response::HTTP_OK);

        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Failed to update request',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Driver Mark Request as Completed
     * POST /api/v1/requests/{id}/completed
     */
    public function completed($id)
    {
        $driver = auth()->user();

        if (!$driver instanceof Driver) {
            return response()->json([
                'status' => false,
                'message' => 'Only drivers can update request status',
            ], Response::HTTP_FORBIDDEN);
        }

        try {
            $result = DB::transaction(function () use ($id, $driver) {
                $request = DB::table('requests')
                    ->where('id', $id)
                    ->lockForUpdate()
                    ->first();

                if (!$request) {
                    return ['status' => false, 'message' => 'Request not found', 'code' => Response::HTTP_NOT_FOUND];
                }

                if ($request->driver_id != $driver->id) {
                    return ['status' => false, 'message' => 'You are not assigned to this request', 'code' => Response::HTTP_FORBIDDEN];
                }

                // Verify transition: arrived → completed
                if ($request->status !== 'arrived') {
                    return ['status' => false, 'message' => 'Request must be arrived to mark as completed', 'code' => Response::HTTP_BAD_REQUEST];
                }

                // Update request status
                DB::table('requests')
                    ->where('id', $id)
                    ->update([
                        'status' => 'completed',
                        'updated_at' => now(),
                    ]);

                // Set driver back to available
                DB::table('drivers')
                    ->where('id', $driver->id)
                    ->update(['status' => 'available']);

                // Log action
                DB::table('request_history')->insert([
                    'request_id' => $id,
                    'action' => 'Request Completed',
                    'actor_type' => 'driver',
                    'actor_id' => $driver->id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                return ['status' => true, 'request' => DB::table('requests')->where('id', $id)->first()];
            });

            if (!$result['status']) {
                return response()->json([
                    'status' => false,
                    'message' => $result['message'],
                ], $result['code']);
            }

            return response()->json([
                'status' => true,
                'message' => 'Request completed',
                'data' => $result['request'],
            ], Response::HTTP_OK);

        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Failed to complete request',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * HELPER: Assign first available driver to request
     * Used automatically on request creation and after rejection
     */
    private function assignAvailableDriver($requestId, $excludedDriverId = null)
{
    $availableDriver = DB::table('drivers')
        ->where('status', 'available')
        ->when($excludedDriverId, function ($query) use ($excludedDriverId) {
            $query->where('id', '!=', $excludedDriverId);
        })
        ->lockForUpdate()
        ->first();

    if (!$availableDriver) {
        return;
    }

    DB::table('requests')
        ->where('id', $requestId)
        ->update([
            'driver_id' => $availableDriver->id,
            'updated_at' => now(),
        ]);

    DB::table('request_history')->insert([
        'request_id' => $requestId,
        'action' => 'Driver Assigned',
        'actor_type' => 'system',
        'actor_id' => null,
        'created_at' => now(),
        'updated_at' => now(),
    ]);
}
}
