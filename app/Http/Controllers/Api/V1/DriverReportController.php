<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class DriverReportController extends Controller
{
    /**
     * Get report data for a driver (shared logic)
     */
    private function getReportData($driverId)
    {
        $month = now()->format('Y-m');

        $driver = DB::table('drivers')
            ->select('id', 'name', 'phone', 'email')
            ->where('id', $driverId)
            ->first();

        if (!$driver) {
            return null;
        }

        $summary = DB::table('driver_monthly_reports')
            ->where('driver_id', $driverId)
            ->where('month', $month)
            ->first();

        $startOfMonth = $month . '-01';
        $endOfMonth   = date('Y-m-t', strtotime($startOfMonth));

        $requests = DB::table('requests')
            ->select(
                'id',
                'request_type',
                'created_at',
                'accepted_at',
                'arrived_at',
                DB::raw('TIMESTAMPDIFF(MINUTE, created_at, accepted_at) as response_time'),
                DB::raw('TIMESTAMPDIFF(MINUTE, accepted_at, arrived_at) as arrival_time'),
                DB::raw('(TIMESTAMPDIFF(MINUTE, created_at, accepted_at) + TIMESTAMPDIFF(MINUTE, accepted_at, arrived_at)) as total_time')
            )
            ->where('driver_id', $driverId)
            ->where('status', 'completed')
            ->whereNotNull('accepted_at')
            ->whereNotNull('arrived_at')
            ->whereBetween('created_at', [$startOfMonth . ' 00:00:00', $endOfMonth . ' 23:59:59'])
            ->orderBy('created_at', 'desc')
            ->get();

        // جلب التقييمات
        $averageRating = DB::table('ratings')
            ->where('driver_id', $driverId)
            ->whereBetween('created_at', [$startOfMonth . ' 00:00:00', $endOfMonth . ' 23:59:59'])
            ->avg('rating') ?? 0;

        $totalRatings = DB::table('ratings')
            ->where('driver_id', $driverId)
            ->whereBetween('created_at', [$startOfMonth . ' 00:00:00', $endOfMonth . ' 23:59:59'])
            ->count();

        $ratings = DB::table('ratings')
            ->where('driver_id', $driverId)
            ->whereBetween('created_at', [$startOfMonth . ' 00:00:00', $endOfMonth . ' 23:59:59'])
            ->get()
            ->keyBy('request_id');

        $ratingStatus = $this->getStatusByRating($averageRating);

        return compact('driver', 'summary', 'requests', 'month', 'averageRating', 'totalRatings', 'ratings', 'ratingStatus');
    }

    /**
     * Get status based on average rating
     */
    private function getStatusByRating($averageRating)
    {
        if ($averageRating >= 4.5) {
            return 'EXCELLENT';
        } elseif ($averageRating >= 3.5) {
            return 'GOOD';
        } elseif ($averageRating >= 2.5) {
            return 'AVERAGE';
        } elseif ($averageRating >= 1.5) {
            return 'POOR';
        } else {
            return 'CRITICAL';
        }
    }

    /**
     * API: JSON Report
     * GET /api/v1/driver-report/{driver_id}
     */
    public function show($driverId)
    {
        $data = $this->getReportData($driverId);

        if (!$data) {
            return response()->json([
                'status' => false,
                'message' => 'Driver not found',
            ], Response::HTTP_NOT_FOUND);
        }

        $ratingStatus = $this->getStatusByRating($data['averageRating']);

        return response()->json([
            'status' => true,
            'data' => [
                'report_title' => 'تقرير أداء السائق الشهري',
                'month' => $data['month'],
                'generated_at' => now()->toDateTimeString(),
                'driver' => $data['driver'],
                'summary' => $data['summary'],
                'average_rating' => round($data['averageRating'], 2),
                'rating_status' => $ratingStatus,
                'total_ratings' => $data['totalRatings'],
                'requests' => $data['requests']->map(function ($r, $index) {
                    return [
                        'number'        => $index + 1,
                        'request_id'    => $r->id,
                        'type'          => $r->request_type,
                        'created_at'    => $r->created_at,
                        'accepted_at'   => $r->accepted_at,
                        'arrived_at'    => $r->arrived_at,
                        'response_time' => $r->response_time,
                        'arrival_time'  => $r->arrival_time,
                        'total_time'    => $r->total_time,
                    ];
                }),
                'total_completed' => $data['requests']->count(),
            ],
        ], Response::HTTP_OK);
    }

    /**
     * Web: Printable HTML Report
     * GET /report/driver/{driver_id}
     */
    public function printable($driverId)
    {
        $data = $this->getReportData($driverId);

        if (!$data) {
            abort(404, 'السائق غير موجود');
        }

        return view('reports.driver-performance', $data);
    }
}
