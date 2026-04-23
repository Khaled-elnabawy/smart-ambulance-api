<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Performance Report - {{ $driver->name }}</title>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Cairo', 'Segoe UI', Tahoma, Arial, sans-serif;
            background: #f5f5f5;
            color: #333;
            direction: ltr;
        }

        .page {
            width: 210mm;
            min-height: 297mm;
            margin: 20px auto;
            padding: 0;
            background: white;
            box-shadow: 0 4px 24px rgba(0,0,0,0.12);
            border-radius: 12px;
            overflow: hidden;
        }

        /* Header */
        .header {
            background: #DC2626;
            color: white;
            padding: 30px 35px;
            position: relative;
            overflow: hidden;
        }

        .header::before {
            content: '';
            position: absolute;
            top: -50px;
            left: -50px;
            width: 200px;
            height: 200px;
            background: rgba(255,255,255,0.08);
            border-radius: 50%;
        }

        .header::after {
            content: '';
            position: absolute;
            bottom: -30px;
            right: -30px;
            width: 120px;
            height: 120px;
            background: rgba(255,255,255,0.06);
            border-radius: 50%;
        }

        .header h1 {
            font-size: 26px;
            font-weight: 800;
            margin-bottom: 4px;
            position: relative;
            z-index: 1;
        }

        .header .subtitle {
            font-size: 14px;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .header .month-badge {
            display: inline-block;
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(4px);
            color: white;
            padding: 6px 22px;
            border-radius: 20px;
            font-size: 15px;
            font-weight: 600;
            margin-top: 12px;
            border: 1px solid rgba(255,255,255,0.3);
            position: relative;
            z-index: 1;
        }

        .content {
            padding: 25px 35px 30px;
        }

        /* Driver Info */
        .driver-info {
            background: #FEF2F2;
            border: 1px solid #FECACA;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
        }

        .driver-info h2 {
            font-size: 16px;
            color: #DC2626;
            margin-bottom: 12px;
            font-weight: 700;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        .info-item {
            font-size: 14px;
        }

        .info-item .label {
            color: #888;
        }

        .info-item .value {
            font-weight: 700;
            color: #333;
        }

        /* Summary Cards */
        .summary-section h2 {
            font-size: 16px;
            color: #DC2626;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
            margin-bottom: 25px;
        }

        .card {
            background: white;
            border: 1px solid #f0f0f0;
            border-radius: 10px;
            padding: 18px 12px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }

        .card .card-value {
            font-size: 26px;
            font-weight: 800;
            color: #DC2626;
        }

        .card .card-label {
            font-size: 11px;
            color: #888;
            margin-top: 6px;
            font-weight: 600;
        }

        /* Status & Ranking */
        .status-row {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 12px;
            margin-bottom: 25px;
        }

        .status-card {
            border-radius: 10px;
            padding: 18px;
            text-align: center;
        }

        .status-high { background: #DCFCE7; border: 2px solid #22c55e; }
        .status-medium { background: #FEF9C3; border: 2px solid #f59e0b; }
        .status-low { background: #FEE2E2; border: 2px solid #ef4444; }

        .status-card .status-value {
            font-size: 22px;
            font-weight: 800;
        }

        .status-high .status-value { color: #16a34a; }
        .status-medium .status-value { color: #d97706; }
        .status-low .status-value { color: #dc2626; }

        .status-card .status-label {
            font-size: 12px;
            color: #666;
            margin-top: 4px;
            font-weight: 600;
        }

        .ranking-card {
            background: #FEF2F2;
            border: 2px solid #DC2626;
        }

        .ranking-card .status-value {
            color: #DC2626;
        }

        /* Requests Table */
        .requests-section {
            margin-top: 25px;
        }

        .requests-section h2 {
            font-size: 16px;
            color: #DC2626;
            margin-bottom: 12px;
            font-weight: 700;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 12px;
            border-radius: 10px;
            overflow: hidden;
        }

        thead th {
            background: #DC2626;
            color: white;
            padding: 12px 8px;
            text-align: center;
            font-weight: 700;
        }

        tbody td {
            padding: 10px 8px;
            border-bottom: 1px solid #f0f0f0;
            text-align: center;
        }

        tbody tr:nth-child(even) {
            background: #FEF2F2;
        }

        tbody tr:hover {
            background: #FECACA30;
        }

        /* Footer */
        .footer {
            margin-top: 30px;
            padding: 20px 35px;
            background: #f9f9f9;
            text-align: center;
            font-size: 12px;
            color: #999;
            border-top: 1px solid #f0f0f0;
        }

        .footer .ambulance-icon {
            font-size: 18px;
            margin-bottom: 4px;
        }

        /* Print Styles */
        .print-btn {
            display: block;
            width: 210mm;
            margin: 15px auto;
            padding: 14px;
            background: #DC2626;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 700;
            font-family: 'Cairo', sans-serif;
            cursor: pointer;
            transition: background 0.2s;
        }

        .print-btn:hover {
            background: #B91C1C;
        }

        @media print {
            body { background: white; }
            .page { box-shadow: none; margin: 0; padding: 0; border-radius: 0; }
            .print-btn { display: none; }
        }
    </style>
</head>
<body>

    <button class="print-btn" onclick="window.print()">Print / Save PDF</button>

    <div class="page">

        <!-- Header -->
        <div class="header">
            <h1> Smart Ambulance</h1>
            <div class="subtitle">Monthly Driver Performance Report</div>
            <div class="month-badge"> {{ $month }}</div>
        </div>

        <div class="content">

            <!-- Driver Info -->
            <div class="driver-info">
                <h2>Driver Information</h2>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="label">Name:</span>
                        <span class="value">{{ $driver->name }}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Driver ID:</span>
                        <span class="value">#{{ $driver->id }}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Phone:</span>
                        <span class="value">{{ $driver->phone }}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Email:</span>
                        <span class="value">{{ $driver->email }}</span>
                    </div>
                </div>
            </div>

            @if($summary)
            <!-- Summary Cards -->
            <div class="summary-section">
                <h2>Performance Summary</h2>
                <div class="cards">
                    <div class="card">
                        <div class="card-value">{{ $summary->total_requests }}</div>
                        <div class="card-label">Total Requests</div>
                    </div>
                    <div class="card">
                        <div class="card-value">{{ $summary->avg_response_time }}</div>
                        <div class="card-label">Avg Response Time (min)</div>
                    </div>
                    <div class="card">
                        <div class="card-value">{{ $summary->avg_arrival_time }}</div>
                        <div class="card-label">Avg Arrival Time (min)</div>
                    </div>
                    <div class="card">
                        <div class="card-value">{{ $summary->efficiency }}</div>
                        <div class="card-label">Efficiency (min)</div>
                    </div>
                </div>

                <!-- Status & Ranking -->
                <div class="status-row">
                    <div class="status-card {{ $summary->status === 'HIGH' ? 'status-high' : ($summary->status === 'MEDIUM' ? 'status-medium' : 'status-low') }}">
                        <div class="status-value">{{ $summary->status }}</div>
                        <div class="status-label">Status</div>
                    </div>
                    <div class="status-card ranking-card">
                        <div class="status-value">#{{ $summary->ranking }}</div>
                        <div class="status-label">Ranking</div>
                    </div>
                    <div class="status-card ranking-card">
                        <div class="status-value">{{ $summary->performance_score }}</div>
                        <div class="status-label">Performance Score</div>
                    </div>
                </div>
            </div>
            @else
            <div style="text-align:center; padding:30px; color:#999;">
                No summary available for this month yet. Run: php artisan drivers:calculate-performance
            </div>
            @endif

            <!-- Requests Breakdown -->
            @if($requests->count() > 0)
            <div class="requests-section">
                <h2>Request Details ({{ $requests->count() }} requests)</h2>
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Request ID</th>
                            <th>Type</th>
                            <th>Created At</th>
                            <th>Accepted At</th>
                            <th>Arrived At</th>
                            <th>Response (min)</th>
                            <th>Arrival (min)</th>
                            <th>Total (min)</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($requests as $index => $r)
                        <tr>
                            <td>{{ $index + 1 }}</td>
                            <td>{{ $r->id }}</td>
                            <td>{{ $r->request_type === 'emergency' ? 'Emergency' : 'Scheduled' }}</td>
                            <td>{{ $r->created_at }}</td>
                            <td>{{ $r->accepted_at }}</td>
                            <td>{{ $r->arrived_at }}</td>
                            <td>{{ $r->response_time }}</td>
                            <td>{{ $r->arrival_time }}</td>
                            <td>{{ $r->total_time }}</td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
            @else
            <div style="text-align:center; padding:30px; color:#999;">
                No completed requests found for this month.
            </div>
            @endif

        </div>

        <!-- Footer -->
        <div class="footer">
            <div class="ambulance-icon">🚑</div>
            Smart Ambulance System — Report generated at {{ now()->format('Y-m-d H:i:s') }}
        </div>
    </div>

</body>
</html>
