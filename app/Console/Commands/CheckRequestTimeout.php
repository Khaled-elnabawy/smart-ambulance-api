<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class CheckRequestTimeout extends Command
{
    protected $signature = 'requests:check-timeout';
    protected $description = 'Reassign requests to the next nearest driver if the current driver does not respond within the timeout period';

    /**
     * Timeout in seconds: if a driver doesn't respond within this time,
     * the request will be reassigned to the next nearest available driver.
     */
    private const TIMEOUT_SECONDS = 120; // 2 minutes

    public function handle(): void
    {
        // Find pending requests that have a driver assigned but no response within timeout
        $timedOutRequests = DB::table('requests')
            ->where('status', 'pending')
            ->whereNotNull('driver_id')
            ->whereNotNull('assigned_at')
            ->where('assigned_at', '<=', now()->subSeconds(self::TIMEOUT_SECONDS))
            ->get();

        if ($timedOutRequests->isEmpty()) {
            $this->info('No timed-out requests found.');
            return;
        }

        foreach ($timedOutRequests as $request) {
            DB::transaction(function () use ($request) {
                $timedOutDriverId = $request->driver_id;

                // Remove driver assignment from request
                DB::table('requests')
                    ->where('id', $request->id)
                    ->update([
                        'driver_id' => null,
                        'assigned_at' => null,
                        'updated_at' => now(),
                    ]);

                // Set the timed-out driver back to available
                DB::table('drivers')
                    ->where('id', $timedOutDriverId)
                    ->update(['status' => 'available']);

                // Log timeout in request history (actor_id = timed out driver)
                DB::table('request_history')->insert([
                    'request_id' => $request->id,
                    'action' => 'Driver Timed Out',
                    'actor_type' => 'system',
                    'actor_id' => $timedOutDriverId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                // Reassign to next nearest available driver (excluding the timed-out driver)
                $this->assignNextDriver($request, $timedOutDriverId);
            });

            $this->info("Request {$request->id}: Driver {$request->driver_id} timed out, reassigning...");
        }
    }

    /**
     * Assign the next nearest available driver using Haversine formula
     */
    private function assignNextDriver($request, $excludedDriverId): void
    {
        $pickupLat = (float) $request->pickup_latitude;
        $pickupLon = (float) $request->pickup_longitude;

        // Collect all drivers who previously timed out on this request
        $timedOutDriverIds = DB::table('request_history')
            ->where('request_id', $request->id)
            ->where('action', 'Driver Timed Out')
            ->pluck('actor_id')
            ->filter()
            ->toArray();

        // Also collect drivers who rejected this request
        $rejectedDriverIds = DB::table('request_history')
            ->where('request_id', $request->id)
            ->where('action', 'Driver Rejected')
            ->pluck('actor_id')
            ->filter()
            ->toArray();

        $excludedIds = array_unique(array_merge($timedOutDriverIds, $rejectedDriverIds, [$excludedDriverId]));

        $availableDriver = DB::table('drivers')
            ->select('id')
            ->selectRaw(
                "6371 * 2 * ASIN(SQRT(
                    POWER(SIN(RADIANS((last_latitude - ?) / 2)), 2) + 
                    COS(RADIANS(?)) * 
                    COS(RADIANS(last_latitude)) * 
                    POWER(SIN(RADIANS((last_longitude - ?) / 2)), 2)
                )) AS distance",
                [$pickupLat, $pickupLat, $pickupLon]
            )
            ->where('status', 'available')
            ->whereNotNull('last_latitude')
            ->whereNotNull('last_longitude')
            ->whereNotIn('id', $excludedIds)
            ->orderBy('distance', 'ASC')
            ->lockForUpdate()
            ->first();

        if (!$availableDriver) {
            $this->warn("Request {$request->id}: No available drivers found.");
            return;
        }

        // Save driver's home location and set status to pending
        DB::table('drivers')
            ->where('id', $availableDriver->id)
            ->update([
                'home_latitude' => DB::raw('last_latitude'),
                'home_longitude' => DB::raw('last_longitude'),
                'status' => 'pending',  // ← Set to pending (awaiting driver response)
            ]);

        // Assign new driver
        DB::table('requests')
            ->where('id', $request->id)
            ->update([
                'driver_id' => $availableDriver->id,
                'assigned_at' => now(),
                'updated_at' => now(),
            ]);

        // Log new assignment
        DB::table('request_history')->insert([
            'request_id' => $request->id,
            'action' => 'Driver Assigned (Timeout Reassign)',
            'actor_type' => 'system',
            'actor_id' => null,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $this->info("Request {$request->id}: Reassigned to driver {$availableDriver->id}");
    }
}
