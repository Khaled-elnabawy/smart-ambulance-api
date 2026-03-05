<?php 
namespace App\Http\Controllers\Api\V1;
 use App\Http\Controllers\Controller; 
 use App\Http\Requests\Api\V1\StoreRequestRequest; 
 use App\Models\Driver; 
 use Illuminate\Support\Facades\DB; 
 use Illuminate\Http\Response;

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
     * Get request details
     * GET /api/v1/requests/{id}
     */
    public function show($id)
    {
        $user = auth()->user();

        try {
            // Get request with driver details
            $request = DB::table('requests as r')
                ->select(
                    'r.id as request_id',
                    'r.status',
                    'r.request_type',
                    'r.pickup_latitude',
                    'r.pickup_longitude',
                    'd.id as driver_id',
                    'd.name as driver_name',
                    'd.phone as driver_phone',
                    'd.last_latitude as driver_last_latitude',
                    'd.last_longitude as driver_last_longitude'
                )
                ->leftJoin('drivers as d', 'r.driver_id', '=', 'd.id')
                ->where('r.id', $id)
                ->first();

            if (!$request) {
                return response()->json([
                    'status' => false,
                    'message' => 'Request not found',
                ], Response::HTTP_NOT_FOUND);
            }

            // Format response data
            $data = [
                'request_id' => $request->request_id,
                'status' => $request->status,
                'request_type' => $request->request_type,
                'pickup_latitude' => $request->pickup_latitude,
                'pickup_longitude' => $request->pickup_longitude,
            ];

            // Include driver details if driver is assigned
            if ($request->driver_id) {
                $data['driver'] = [
                    'id' => $request->driver_id,
                    'name' => $request->driver_name,
                    'phone' => $request->driver_phone,
                    'last_latitude' => $request->driver_last_latitude,
                    'last_longitude' => $request->driver_last_longitude,
                ];
            }

            return response()->json([
                'status' => true,
                'data' => $data,
            ], Response::HTTP_OK);

        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Failed to retrieve request',
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
                    return ['status' => false, 'message' => 'Request must be accepted to mark as arrived', 'code' => Response::HTTP_BAD_REQUEST];
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

            // Get driver record
            $driverRecord = DB::table('drivers')
                ->where('id', $driver->id)
                ->first();

            // fallback لو home location null
            $latitude = $driverRecord->home_latitude ?? $driverRecord->last_latitude;
            $longitude = $driverRecord->home_longitude ?? $driverRecord->last_longitude;

            // Reset driver location
            DB::table('drivers')
                ->where('id', $driver->id)
                ->update([
                    'last_latitude' => $latitude,
                    'last_longitude' => $longitude,
                    'home_latitude' => null,
                    'home_longitude' => null,
                    'status' => 'available',
                    'updated_at' => now(),
                ]);

            // Log action
            DB::table('request_history')->insert([
                'request_id' => $id,
                'action' => 'Request Completed',
                'actor_type' => 'driver',
                'actor_id' => $driver->id,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            return [
                'status' => true,
                'request' => DB::table('requests')->where('id', $id)->first()
            ];
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
     * User Cancel Request
     * POST /api/v1/requests/{id}/cancel
     */
    public function cancel($id)
    {
        $user = auth()->user();

        // Authorization: Only users can cancel requests
        if ($user instanceof Driver) {
            return response()->json([
                'status' => false,
                'message' => 'Only users can cancel requests',
            ], Response::HTTP_FORBIDDEN);
        }

        try {
            $result = DB::transaction(function () use ($id, $user) {
                // Get request with lock
                $request = DB::table('requests')
                    ->where('id', $id)
                    ->lockForUpdate()
                    ->first();

                if (!$request) {
                    return ['status' => false, 'message' => 'Request not found', 'code' => Response::HTTP_NOT_FOUND];
                }

                // Verify the request belongs to the authenticated user
                if ($request->user_id != $user->id) {
                    return ['status' => false, 'message' => 'You are not authorized to cancel this request', 'code' => Response::HTTP_FORBIDDEN];
                }

                // Verify request status is pending (cancellation only allowed for pending requests)
                if ($request->status !== 'pending') {
                    return ['status' => false, 'message' => 'Request cannot be cancelled', 'code' => Response::HTTP_BAD_REQUEST];
                }

                // Update request status to cancelled
                DB::table('requests')
                    ->where('id', $id)
                    ->update([
                        'status' => 'cancelled',
                        'updated_at' => now(),
                    ]);

                // If driver is assigned, release them and set back to available
                if ($request->driver_id) {
                    DB::table('drivers')
                        ->where('id', $request->driver_id)
                        ->update(['status' => 'available']);
                }

                // Log the cancellation action
                DB::table('request_history')->insert([
                    'request_id' => $id,
                    'action' => 'Request Cancelled By User',
                    'actor_type' => 'user',
                    'actor_id' => $user->id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                return ['status' => true];
            });

            if (!$result['status']) {
                return response()->json([
                    'status' => false,
                    'message' => $result['message'],
                ], $result['code']);
            }

            return response()->json([
                'status' => true,
                'message' => 'Request cancelled successfully',
            ], Response::HTTP_OK);

        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Failed to cancel request',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * HELPER: Assign nearest available driver to request using Haversine formula
     * Used automatically on request creation and after rejection
     * 
     * Uses the Haversine formula to calculate the great-circle distance
     * between the driver's current location and the request pickup location.
     * Distance calculated in kilometers.
     */
    private function assignAvailableDriver($requestId, $excludedDriverId = null)
    {
        // Get the pickup location from the request
        $request = DB::table('requests')
            ->where('id', $requestId)
            ->first();

        if (!$request) {
            return;
        }

        $pickupLat = (float) $request->pickup_latitude;
        $pickupLon = (float) $request->pickup_longitude;

        // Haversine formula: calculates distance in kilometers
        // Distance = 6371 * 2 * ASIN(SQRT(SIN²((lat2-lat1)/2) + COS(lat1)*COS(lat2)*SIN²((lon2-lon1)/2)))
        // Using selectRaw for the distance calculation with values from request
        $availableDriver = DB::table('drivers')
            ->select('drivers.id')
            ->selectRaw(
                "6371 * 2 * ASIN(SQRT(
                    POWER(SIN(RADIANS((drivers.last_latitude - ?) / 2)), 2) + 
                    COS(RADIANS(?)) * 
                    COS(RADIANS(drivers.last_latitude)) * 
                    POWER(SIN(RADIANS((drivers.last_longitude - ?) / 2)), 2)
                )) AS distance",
                [$pickupLat, $pickupLat, $pickupLon]
            )
            ->where('status', 'available')
            ->whereNotNull('last_latitude')
            ->whereNotNull('last_longitude')
            ->when($excludedDriverId, function ($query) use ($excludedDriverId) {
                $query->where('id', '!=', $excludedDriverId);
            })
            ->orderBy('distance', 'ASC')
            ->lockForUpdate()
            ->first();

        if (!$availableDriver) {
            return;
        }

        // Save driver's current location before assigning the request
        // This allows the driver to return to their original location after completing the trip
        DB::table('drivers')
            ->where('id', $availableDriver->id)
            ->update([
                'home_latitude' => DB::raw('last_latitude'),
                'home_longitude' => DB::raw('last_longitude'),
            ]);

        // Assign the nearest driver to the request
        DB::table('requests')
            ->where('id', $requestId)
            ->update([
                'driver_id' => $availableDriver->id,
                'updated_at' => now(),
            ]);

        // Log the assignment in request history
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