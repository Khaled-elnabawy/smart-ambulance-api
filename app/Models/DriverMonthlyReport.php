<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DriverMonthlyReport extends Model
{
    /**
     * Disable updated_at since the table only has created_at.
     */
    const UPDATED_AT = null;

    protected $fillable = [
        'driver_id',
        'month',
        'total_requests',
        'avg_response_time',
        'avg_arrival_time',
        'efficiency',
        'performance_score',
        'ranking',
        'status',
    ];

    protected $casts = [
        'total_requests'    => 'integer',
        'avg_response_time' => 'float',
        'avg_arrival_time'  => 'float',
        'efficiency'        => 'float',
        'performance_score' => 'float',
        'ranking'           => 'integer',
    ];

    /**
     * Get the driver that owns this report.
     */
    public function driver()
    {
        return $this->belongsTo(Driver::class);
    }
}
