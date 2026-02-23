<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\V1\StoreRequestRequest;
use App\Models\Driver;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Response;

class RequestController extends Controller
{
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
}