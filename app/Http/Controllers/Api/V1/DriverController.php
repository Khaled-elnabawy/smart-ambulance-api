<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\V1\UpdateDriverLocationRequest;
use App\Models\Driver;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Response;

class DriverController extends Controller
{
    /**
     * Update driver's current location
     * POST /api/v1/driver/location
     */
    public function updateLocation(UpdateDriverLocationRequest $request)
    {
        $driver = auth()->user();

        // Ensure only drivers can update location
        if (!$driver instanceof Driver) {
            return response()->json([
                'status' => false,
                'message' => 'Only drivers can update location',
            ], Response::HTTP_FORBIDDEN);
        }

        // Allow location update only if driver is on an active trip
        if ($driver->status !== 'busy') {
            return response()->json([
                'status' => false,
                'message' => 'Driver is not on an active trip'
            ], Response::HTTP_FORBIDDEN);
        }

        try {

            DB::table('drivers')
                ->where('id', $driver->id)
                ->update([
                    'last_latitude' => $request->latitude,
                    'last_longitude' => $request->longitude,
                    'last_location_update' => now(),
                    'updated_at' => now(),
                ]);

            return response()->json([
                'status' => true,
                'message' => 'Driver location updated successfully',
            ], Response::HTTP_OK);

        } catch (\Exception $e) {

            return response()->json([
                'status' => false,
                'message' => 'Failed to update driver location',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}