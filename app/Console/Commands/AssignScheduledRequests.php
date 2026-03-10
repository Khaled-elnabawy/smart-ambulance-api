<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class AssignScheduledRequests extends Command
{
    protected $signature = 'requests:assign-scheduled';
    protected $description = 'Assign drivers to scheduled requests that are within 10 minutes of their scheduled time';

    public function handle(): void
    {
        // Find pending scheduled requests without a driver, within 10 minutes of scheduled_time
        $requests = DB::table('requests')
            ->where('status', 'pending')
            ->where('request_type', 'scheduled')
            ->whereNull('driver_id')
            ->whereNotNull('scheduled_time')
            ->where('scheduled_time', '<=', now()->addMinutes(10))
            ->get();

        foreach ($requests as $request) {
            $pickupLat = (float) $request->pickup_latitude;
            $pickupLon = (float) $request->pickup_longitude;

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
                ->orderBy('distance', 'ASC')
                ->lockForUpdate()
                ->first();

            if (!$availableDriver) {
                continue;
            }

            DB::transaction(function () use ($request, $availableDriver) {
                // Save driver's home location
                DB::table('drivers')
                    ->where('id', $availableDriver->id)
                    ->update([
                        'home_latitude' => DB::raw('last_latitude'),
                        'home_longitude' => DB::raw('last_longitude'),
                    ]);

                // Assign driver to request
                DB::table('requests')
                    ->where('id', $request->id)
                    ->update([
                        'driver_id' => $availableDriver->id,
                        'updated_at' => now(),
                    ]);

                // Log assignment
                DB::table('request_history')->insert([
                    'request_id' => $request->id,
                    'action' => 'Driver Assigned (Scheduled)',
                    'actor_type' => 'system',
                    'actor_id' => null,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            });

            $this->info("Assigned driver {$availableDriver->id} to scheduled request {$request->id}");
        }
    }
}
