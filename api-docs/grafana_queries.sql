-- =============================================
-- Grafana Dashboard Queries
-- Smart Ambulance — Driver Performance Analysis
-- =============================================

-- -----------------------------------------
-- 1. Performance Overview (selected month)
-- Use Grafana variable: $month (e.g. 2026-04)
-- -----------------------------------------
SELECT
    r.driver_id,
    d.name AS driver_name,
    r.total_requests,
    r.avg_response_time,
    r.avg_arrival_time,
    r.efficiency,
    r.performance_score,
    r.ranking,
    r.status,
    r.month
FROM driver_monthly_reports r
JOIN drivers d ON d.id = r.driver_id
WHERE r.month = '$month'
ORDER BY r.performance_score DESC;

-- -----------------------------------------
-- 2. Top 5 Drivers (Best Performance)
-- -----------------------------------------
SELECT
    r.driver_id,
    d.name AS driver_name,
    r.total_requests,
    r.avg_response_time,
    r.avg_arrival_time,
    r.efficiency,
    r.performance_score,
    r.ranking,
    r.status
FROM driver_monthly_reports r
JOIN drivers d ON d.id = r.driver_id
WHERE r.month = '$month'
ORDER BY r.ranking ASC
LIMIT 5;

-- -----------------------------------------
-- 3. Bottom 5 Drivers (Worst Performance)
-- -----------------------------------------
SELECT
    r.driver_id,
    d.name AS driver_name,
    r.total_requests,
    r.avg_response_time,
    r.avg_arrival_time,
    r.efficiency,
    r.performance_score,
    r.ranking,
    r.status
FROM driver_monthly_reports r
JOIN drivers d ON d.id = r.driver_id
WHERE r.month = '$month'
ORDER BY r.ranking DESC
LIMIT 5;

-- -----------------------------------------
-- 4. Status Distribution (Pie Chart)
-- -----------------------------------------
SELECT
    status,
    COUNT(*) AS driver_count
FROM driver_monthly_reports
WHERE month = '$month'
GROUP BY status;

-- -----------------------------------------
-- 5. Monthly Trend per Driver (Time Series)
-- Use Grafana variable: $driver_id
-- -----------------------------------------
SELECT
    month,
    performance_score,
    total_requests,
    efficiency
FROM driver_monthly_reports
WHERE driver_id = $driver_id
ORDER BY month ASC;

-- -----------------------------------------
-- 6. Average Fleet Performance per Month
-- -----------------------------------------
SELECT
    month,
    AVG(performance_score) AS avg_score,
    AVG(avg_response_time) AS avg_response,
    AVG(avg_arrival_time) AS avg_arrival,
    AVG(efficiency) AS avg_efficiency,
    SUM(total_requests) AS total_fleet_requests
FROM driver_monthly_reports
GROUP BY month
ORDER BY month ASC;

-- -----------------------------------------
-- 7. Per-Request Breakdown (Table)
-- Shows each request with its individual times
-- Use Grafana variables: $driver_id, $month
-- -----------------------------------------
SELECT
    r.id AS request_id,
    r.request_type,
    r.created_at,
    r.accepted_at,
    r.arrived_at,
    TIMESTAMPDIFF(MINUTE, r.created_at, r.accepted_at) AS response_time_min,
    TIMESTAMPDIFF(MINUTE, r.accepted_at, r.arrived_at) AS arrival_time_min,
    TIMESTAMPDIFF(MINUTE, r.created_at, r.arrived_at) AS total_time_min
FROM requests r
WHERE r.driver_id = $driver_id
  AND r.status = 'completed'
  AND r.accepted_at IS NOT NULL
  AND r.arrived_at IS NOT NULL
  AND r.created_at BETWEEN CONCAT('$month', '-01') AND LAST_DAY(CONCAT('$month', '-01'))
ORDER BY r.created_at DESC;
