<?php 
namespace App\Http\Controllers\Api\V1;
 use App\Http\Controllers\Controller; 
 use App\Http\Requests\Api\V1\StoreRequestRequest; 
 use App\Models\Driver; 
 use Illuminate\Support\Facades\DB; 
 use Illuminate\Http\Response;
 use Illuminate\Validation\ValidationException;
 use Carbon\Carbon;

class RequestController extends Controller
{
    /**
     * Get authenticated user's or driver's requests
     * GET /api/v1/my-requests
     * Query params: ?type=emergency|scheduled  &status=pending|accepted|arrived|completed|cancelled
     */
    public function myRequests()
    {
        $user = auth()->user();
        $isDriver = $user instanceof Driver;

        $query = DB::table('requests')
            ->select(
                'id',
                'request_type',
                'status',
                'pickup_latitude',
                'pickup_longitude',
                'destination_latitude',
                'destination_longitude',
                'destination_name',
                'scheduled_time',
                'members_count',
                'driver_id',
                'user_id',
                'created_at'
            )
            ->where($isDriver ? 'driver_id' : 'user_id', $user->id);

        // Filter by request type (emergency / scheduled)
        if (request()->has('type')) {
            $query->where('request_type', request('type'));
        }

        // Filter by status
        if (request()->has('status')) {
            $query->where('status', request('status'));
        }

        $requests = $query->orderBy('created_at', 'desc')->get();

        return response()->json([
            'status' => true,
            'data' => $requests,
        ], Response::HTTP_OK);
    }

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

        // Check if user already has an active request
        $activeRequest = DB::table('requests')
            ->where('user_id', $user->id)
            ->whereIn('status', ['pending', 'accepted', 'arrived'])
            ->first();

        if ($activeRequest) {
            return response()->json([
                'status' => false,
                'message' => 'You already have an active request. Please complete or cancel it first.',
            ], Response::HTTP_CONFLICT);
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
                    'destination_latitude' => $validated['destination_latitude'] ?? null,
                    'destination_longitude' => $validated['destination_longitude'] ?? null,
                    'destination_name' => $validated['destination_name'] ?? null,
                    'scheduled_time' => $validated['scheduled_time'] ?? null,
                    'members_count' => $validated['members_count'] ?? 1,
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
                // Skip assignment for scheduled requests more than 10 minutes away
                $shouldAssignNow = $validated['request_type'] === 'emergency'
                    || empty($validated['scheduled_time'])
                    || Carbon::parse($validated['scheduled_time'])->diffInMinutes(now(), false) >= -10;

                if ($shouldAssignNow) {
                    $this->assignAvailableDriver($newRequestId);
                }

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
                    'r.destination_latitude',
                    'r.destination_longitude',
                    'r.destination_name',
                    'r.scheduled_time',
                    'r.members_count',
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
                'destination_latitude' => $request->destination_latitude,
                'destination_longitude' => $request->destination_longitude,
                'destination_name' => $request->destination_name,
                'scheduled_time' => $request->scheduled_time,
                'members_count' => $request->members_count,
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
     * POST /api/v1/requests/accept
     * Body: { "id": <request_id> }
     */
    public function accept()
    {
        $driver = auth()->user();

        // Ensure only drivers can accept
        if (!$driver instanceof Driver) {
            return response()->json([
                'status' => false,
                'message' => 'Only drivers can accept requests',
            ], Response::HTTP_FORBIDDEN);
        }

        $id = request()->input('id');

        if (!$id) {
            return response()->json([
                'status' => false,
                'message' => 'Request ID is required',
            ], Response::HTTP_BAD_REQUEST);
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
                        'accepted_at' => now(),
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
     * POST /api/v1/requests/reject
     * Body: { "id": <request_id> }
     */
    public function reject()
    {
        $driver = auth()->user();

        // Ensure only drivers can reject
        if (!$driver instanceof Driver) {
            return response()->json([
                'status' => false,
                'message' => 'Only drivers can reject requests',
            ], Response::HTTP_FORBIDDEN);
        }

        $id = request()->input('id');

        if (!$id) {
            return response()->json([
                'status' => false,
                'message' => 'Request ID is required',
            ], Response::HTTP_BAD_REQUEST);
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
     * POST /api/v1/requests/arrived
     * Body: { "id": <request_id> }
     */
    public function arrived()
    {
        $driver = auth()->user();

        if (!$driver instanceof Driver) {
            return response()->json([
                'status' => false,
                'message' => 'Only drivers can update request status',
            ], Response::HTTP_FORBIDDEN);
        }

        $id = request()->input('id');

        if (!$id) {
            return response()->json([
                'status' => false,
                'message' => 'Request ID is required',
            ], Response::HTTP_BAD_REQUEST);
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
                        'arrived_at' => now(),
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
     * POST /api/v1/requests/completed
     * Body: { "id": <request_id> }
     */
    public function completed()
{
    $driver = auth()->user();

    if (!$driver instanceof Driver) {
        return response()->json([
            'status' => false,
            'message' => 'Only drivers can update request status',
        ], Response::HTTP_FORBIDDEN);
    }

    $id = request()->input('id');

    if (!$id) {
        return response()->json([
            'status' => false,
            'message' => 'Request ID is required',
        ], Response::HTTP_BAD_REQUEST);
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
     * POST /api/v1/requests/cancel
     * Body: { "id": <request_id> }
     */
    public function cancel()
    {
        $user = auth()->user();

        // Authorization: Only users can cancel requests
        if ($user instanceof Driver) {
            return response()->json([
                'status' => false,
                'message' => 'Only users can cancel requests',
            ], Response::HTTP_FORBIDDEN);
        }

        // Get request ID from body
        $id = request()->input('id');

        if (!$id) {
            return response()->json([
                'status' => false,
                'message' => 'Request ID is required',
            ], Response::HTTP_BAD_REQUEST);
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
     * User Rate Driver
     * POST /api/v1/requests/rate
     * Body: { "id": <request_id>, "rating": 1-5 }
     */
    public function rate()
    {
        $user = auth()->user();

        // Only users can rate drivers
        if ($user instanceof Driver) {
            return response()->json([
                'status' => false,
                'message' => 'Only users can rate drivers',
            ], Response::HTTP_FORBIDDEN);
        }

        // Validate input
        $validated = request()->validate([
            'id' => 'required|integer',
            'rating' => 'required|integer|min:1|max:5',
        ]);

        $id = $validated['id'];

        try {
            $result = DB::transaction(function () use ($id, $user, $validated) {
                $request = DB::table('requests')
                    ->where('id', $id)
                    ->first();

                if (!$request) {
                    return ['status' => false, 'message' => 'Request not found', 'code' => Response::HTTP_NOT_FOUND];
                }

                // Verify the request belongs to this user
                if ($request->user_id != $user->id) {
                    return ['status' => false, 'message' => 'You are not authorized to rate this request', 'code' => Response::HTTP_FORBIDDEN];
                }

                // Verify request is completed
                if ($request->status !== 'completed') {
                    return ['status' => false, 'message' => 'You can only rate completed requests', 'code' => Response::HTTP_BAD_REQUEST];
                }

                // Verify a driver was assigned
                if (!$request->driver_id) {
                    return ['status' => false, 'message' => 'No driver assigned to this request', 'code' => Response::HTTP_BAD_REQUEST];
                }

                // Check if already rated
                $existingRating = DB::table('ratings')
                    ->where('request_id', $id)
                    ->first();

                if ($existingRating) {
                    return ['status' => false, 'message' => 'You have already rated this request', 'code' => Response::HTTP_CONFLICT];
                }

                // Create rating
                DB::table('ratings')->insert([
                    'request_id' => $id,
                    'user_id' => $user->id,
                    'driver_id' => $request->driver_id,
                    'rating' => $validated['rating'],
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                // Calculate new average rating for the driver
                $avgRating = DB::table('ratings')
                    ->where('driver_id', $request->driver_id)
                    ->avg('rating');

                return [
                    'status' => true,
                    'data' => [
                        'rating' => $validated['rating'],
                        'driver_average_rating' => round($avgRating, 2),
                    ],
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
                'message' => 'Rating submitted successfully',
                'data' => $result['data'],
            ], Response::HTTP_CREATED);

        } catch (ValidationException $e) {
            return response()->json([
                'status' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Failed to submit rating',
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
                'assigned_at' => now(),
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