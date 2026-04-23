<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class CalculateDriverPerformance extends Command
{
    /**
     * The name and signature of the console command.
     */
    protected $signature = 'drivers:calculate-performance
                            {--month= : Month to calculate in YYYY-MM format (defaults to current month)}';

    /**
     * The console command description.
     */
    protected $description = 'Calculate monthly driver performance metrics and store in driver_monthly_reports';

    /**
     * Execute the console command.
     */
    public function handle(): int
    {
        $month = $this->option('month') ?? Carbon::now()->format('Y-m');

        // Validate month format
        if (!preg_match('/^\d{4}-\d{2}$/', $month)) {
            $this->error("Invalid month format. Use YYYY-MM (e.g. 2026-04)");
            return self::FAILURE;
        }

        $this->info("Calculating driver performance for month: {$month}");

        // Step 1: Query performance data from completed requests
        $startOfMonth = Carbon::parse($month . '-01')->startOfMonth();
        $endOfMonth   = Carbon::parse($month . '-01')->endOfMonth();

        $results = DB::table('requests')
            ->select(
                'driver_id',
                DB::raw("COUNT(*) as total_requests"),
                DB::raw("ROUND(AVG(TIMESTAMPDIFF(MINUTE, created_at, accepted_at)), 2) as avg_response_time"),
                DB::raw("ROUND(AVG(TIMESTAMPDIFF(MINUTE, accepted_at, arrived_at)), 2) as avg_arrival_time")
            )
            ->whereNotNull('driver_id')
            ->whereNotNull('accepted_at')
            ->whereNotNull('arrived_at')
            ->where('status', 'completed')
            ->whereBetween('created_at', [$startOfMonth, $endOfMonth])
            ->groupBy('driver_id')
            ->get();

        if ($results->isEmpty()) {
            $this->warn("No completed requests found for {$month}. Nothing to report.");
            return self::SUCCESS;
        }

        // Step 2: Calculate derived metrics
        $reports = $results->map(function ($row) use ($month) {
            $avgResponse = (float) $row->avg_response_time;
            $avgArrival  = (float) $row->avg_arrival_time;
            $efficiency  = round($avgResponse + $avgArrival, 2);
            $score       = round($row->total_requests / ($avgResponse + $avgArrival + 1), 4);

            return [
                'driver_id'         => $row->driver_id,
                'month'             => $month,
                'total_requests'    => $row->total_requests,
                'avg_response_time' => $avgResponse,
                'avg_arrival_time'  => $avgArrival,
                'efficiency'        => $efficiency,
                'performance_score' => $score,
            ];
        });

        // Step 3: Sort by performance_score DESC and assign rankings
        $reports = $reports->sortByDesc('performance_score')->values();
        $totalDrivers = $reports->count();

        foreach ($reports as $index => $report) {
            $ranking = $index + 1;

            // Status classification based on percentile position
            if ($ranking <= ceil($totalDrivers * 0.25)) {
                $status = 'HIGH';
            } elseif ($ranking <= ceil($totalDrivers * 0.75)) {
                $status = 'MEDIUM';
            } else {
                $status = 'LOW';
            }

            // Upsert into driver_monthly_reports
            DB::table('driver_monthly_reports')->updateOrInsert(
                [
                    'driver_id' => $report['driver_id'],
                    'month'     => $month,
                ],
                [
                    'total_requests'    => $report['total_requests'],
                    'avg_response_time' => $report['avg_response_time'],
                    'avg_arrival_time'  => $report['avg_arrival_time'],
                    'efficiency'        => $report['efficiency'],
                    'performance_score' => $report['performance_score'],
                    'ranking'           => $ranking,
                    'status'            => $status,
                    'created_at'        => now(),
                ]
            );
        }

        $this->info("Successfully processed {$totalDrivers} driver(s) for {$month}.");

        // Display summary table
        $this->table(
            ['Rank', 'Driver ID', 'Requests', 'Avg Response (min)', 'Avg Arrival (min)', 'Efficiency', 'Score', 'Status'],
            $reports->map(function ($r, $index) use ($totalDrivers) {
                $ranking = $index + 1;
                $status = $ranking <= ceil($totalDrivers * 0.25) ? 'HIGH' :
                         ($ranking <= ceil($totalDrivers * 0.75) ? 'MEDIUM' : 'LOW');

                return [
                    $ranking,
                    $r['driver_id'],
                    $r['total_requests'],
                    $r['avg_response_time'],
                    $r['avg_arrival_time'],
                    $r['efficiency'],
                    $r['performance_score'],
                    $status,
                ];
            })->toArray()
        );

        return self::SUCCESS;
    }
}
