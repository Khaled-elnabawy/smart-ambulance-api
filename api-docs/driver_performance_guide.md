# 🚑 شرح الكود سطر بسطر — Driver Performance Analysis

---

## 📁 ملف 1: Migration — إضافة أعمدة الأوقات

```
المسار: database/migrations/2026_04_11_add_performance_timestamps_to_requests.php
```

### الكود:

```php
<?php

use Illuminate\Database\Migrations\Migration;   // ← كلاس الـ migration
use Illuminate\Database\Schema\Blueprint;        // ← كلاس بيرسم شكل الجدول
use Illuminate\Support\Facades\Schema;           // ← أداة التعامل مع الجداول

return new class extends Migration
{
    public function up(): void    // ← الدالة دي بتشتغل لما تعمل migrate
    {
        Schema::table('requests', function (Blueprint $table) {
            // ↑ بنقوله: روح على جدول requests الموجود وعدّل فيه

            $table->timestamp('accepted_at')->nullable()->after('status');
            // ↑ ضيف عمود اسمه accepted_at
            //   نوعه timestamp (تاريخ ووقت)
            //   nullable() → يعني مسموح يكون فاضي (مش كل طلب بيتقبل)
            //   after('status') → حطه بعد عمود status

            $table->timestamp('arrived_at')->nullable()->after('accepted_at');
            // ↑ نفس الكلام — عمود للوقت اللي السائق وصل فيه
        });
    }

    public function down(): void   // ← الدالة دي بتشتغل لما تعمل rollback (ترجع ورا)
    {
        Schema::table('requests', function (Blueprint $table) {
            $table->dropColumn(['accepted_at', 'arrived_at']);
            // ↑ بيمسح العمودين لو عملت rollback
        });
    }
};
```

### يعني إيه؟
- **`up()`** = لما تعمل `php artisan migrate` → بيضيف العمودين
- **`down()`** = لما تعمل `php artisan migrate:rollback` → بيمسحهم
- **`nullable()`** = العمود ممكن يكون فاضي — لأن الطلب ممكن يتلغي قبل ما السائق يقبل

---

## 📁 ملف 2: Migration — جدول التقارير الشهرية

```
المسار: database/migrations/2026_04_11_create_driver_monthly_reports_table.php
```

### الكود:

```php
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('driver_monthly_reports', function (Blueprint $table) {
            // ↑ بنعمل جدول جديد اسمه driver_monthly_reports

            $table->id();
            // ↑ عمود id تلقائي (1, 2, 3, 4...)

            $table->foreignId('driver_id')
                  ->constrained()       // ← بيربطه بجدول drivers (foreign key)
                  ->cascadeOnDelete();   // ← لو السائق اتمسح، تقاريره تتمسح معاه
            // ↑ رقم السائق — لازم يكون موجود في جدول drivers

            $table->char('month', 7);
            // ↑ الشهر — نص مكوّن من 7 حروف مثلاً: "2026-04"

            $table->unsignedInteger('total_requests')->default(0);
            // ↑ عدد الطلبات — رقم صحيح موجب — لو مكتبناش قيمة يبقى 0

            $table->decimal('avg_response_time', 10, 2)->default(0);
            // ↑ متوسط وقت القبول — رقم عشري  (10 أرقام، 2 منهم بعد الفاصلة)
            //   مثال: 3.50 يعني 3 دقايق ونص

            $table->decimal('avg_arrival_time', 10, 2)->default(0);
            // ↑ متوسط وقت الوصول

            $table->decimal('efficiency', 10, 2)->default(0);
            // ↑ الكفاءة = avg_response_time + avg_arrival_time

            $table->decimal('performance_score', 10, 4)->default(0);
            // ↑ نقاط الأداء — 4 أرقام بعد الفاصلة عشان الدقة
            //   مثال: 0.9091

            $table->unsignedInteger('ranking')->default(0);
            // ↑ الترتيب — 1 يعني الأحسن

            $table->enum('status', ['HIGH', 'MEDIUM', 'LOW'])->default('MEDIUM');
            // ↑ الحالة — واحدة من 3 قيم بس
            //   enum يعني: العمود ده مسموح فيه القيم دي بس

            $table->timestamp('created_at')->nullable();
            // ↑ تاريخ إنشاء التقرير

            $table->unique(['driver_id', 'month']);
            // ↑ مينفعش يكون فيه سطرين بنفس driver_id ونفس month
            //   يعني كل سائق ليه تقرير واحد بس في الشهر
            //   لو حاولنا ندخل تاني، بيتحدث مش بيتكرر
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('driver_monthly_reports');
        // ↑ لو عملنا rollback → بيمسح الجدول بالكامل
    }
};
```

---

## 📁 ملف 3: Model — DriverMonthlyReport

```
المسار: app/Models/DriverMonthlyReport.php
```

### الكود:

```php
<?php

namespace App\Models;
// ↑ ده المكان بتاع الملف في المشروع

use Illuminate\Database\Eloquent\Model;
// ↑ بنستورد كلاس Model — ده اللي بيخلينا نتعامل مع الجدول

class DriverMonthlyReport extends Model
{
    const UPDATED_AT = null;
    // ↑ الجدول بتاعنا مفيهوش عمود updated_at
    //   فبنقول لـ Laravel: متدوّرش عليه

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
    // ↑ الأعمدة اللي مسموح نكتب فيها
    //   ده حماية من Laravel — عشان محدش يبعت بيانات غلط

    protected $casts = [
        'total_requests'    => 'integer',   // ← خليه رقم صحيح
        'avg_response_time' => 'float',     // ← خليه رقم عشري
        'avg_arrival_time'  => 'float',
        'efficiency'        => 'float',
        'performance_score' => 'float',
        'ranking'           => 'integer',
    ];
    // ↑ casts → بتحوّل القيم للنوع الصح
    //   لأن الـ database بترجع كل حاجة كـ string
    //   فبنقوله: لا، ده رقم مش نص

    public function driver()
    {
        return $this->belongsTo(Driver::class);
    }
    // ↑ علاقة: كل تقرير بيبقى تابع لسائق واحد
    //   $report->driver->name ← بيجيبلك اسم السائق
}
```

---

## 📁 ملف 4: التعديل على RequestController

```
المسار: app/Http/Controllers/Api/V1/RequestController.php
```

### التعديل في accept():

```php
// لما السائق يقبل الطلب:
DB::table('requests')
    ->where('id', $id)
    ->where('status', 'pending')
    ->update([
        'status' => 'accepted',
        'accepted_at' => now(),    // ← ده الجديد
        'updated_at' => now(),
    ]);
```

**شرح `now()`:**
```
now() → بترجع الوقت الحالي
مثال: 2026-04-13 13:30:45
```

يعني لما السائق يدوس "قبول" الساعة 1:30 → `accepted_at = 2026-04-13 13:30:45`

### التعديل في arrived():

```php
// لما السائق يوصل المكان:
DB::table('requests')
    ->where('id', $id)
    ->update([
        'status' => 'arrived',
        'arrived_at' => now(),     // ← ده الجديد
        'updated_at' => now(),
    ]);
```

يعني لما السائق يدوس "وصلت" الساعة 1:45 → `arrived_at = 2026-04-13 13:45:00`

### فايدة الكلام ده:
دلوقتي نقدر نحسب:
```
وقت القبول  = accepted_at - created_at = 13:30 - 13:25 = 5 دقايق
وقت الوصول = arrived_at - accepted_at = 13:45 - 13:30 = 15 دقيقة
```

---

## 📁 ملف 5: Command — حساب الأداء (الملف الأهم)

```
المسار: app/Console/Commands/CalculateDriverPerformance.php
```

### الكود خطوة بخطوة:

```php
protected $signature = 'drivers:calculate-performance
                        {--month= : Month to calculate in YYYY-MM format}';
// ↑ اسم الأمر: drivers:calculate-performance
//   --month= → خيار اختياري تحدد فيه الشهر
//   مثال: php artisan drivers:calculate-performance --month=2026-04
```

```php
public function handle(): int
{
    $month = $this->option('month') ?? Carbon::now()->format('Y-m');
    // ↑ لو كتبت --month=2026-04 → بياخد 2026-04
    //   لو مكتبتش → بياخد الشهر الحالي أوتوماتيك
    //   ?? يعني: لو القيمة فاضية استخدم اللي بعدها
```

### الخطوة 1: جلب البيانات

```php
    $results = DB::table('requests')
        ->select(
            'driver_id',
            DB::raw("COUNT(*) as total_requests"),
            // ↑ COUNT(*) → بيعدّ عدد الصفوف (الطلبات)

            DB::raw("ROUND(AVG(TIMESTAMPDIFF(MINUTE, created_at, accepted_at)), 2) as avg_response_time"),
            // ↑ TIMESTAMPDIFF(MINUTE, created_at, accepted_at)
            //   → بيحسب الفرق بالدقايق بين وقت الإنشاء ووقت القبول
            //   AVG() → بيحسب المتوسط لكل الطلبات
            //   ROUND(, 2) → بيقرّب لرقمين بعد الفاصلة
            //   مثال: طلب 1 = 3 دق، طلب 2 = 5 دق → AVG = 4.00

            DB::raw("ROUND(AVG(TIMESTAMPDIFF(MINUTE, accepted_at, arrived_at)), 2) as avg_arrival_time")
            // ↑ نفس الكلام بس من وقت القبول لحد وقت الوصول
        )
        ->whereNotNull('driver_id')      // ← الطلب لازم يكون فيه سائق
        ->whereNotNull('accepted_at')    // ← لازم يكون اتقبل
        ->whereNotNull('arrived_at')     // ← لازم السائق يكون وصل
        ->where('status', 'completed')   // ← الطلب لازم يكون مكتمل
        ->whereBetween('created_at', [$startOfMonth, $endOfMonth])
        // ↑ بس الطلبات اللي في الشهر ده
        ->groupBy('driver_id')
        // ↑ بيجمّع النتايج بالسائق — يعني كل سائق صف واحد
        ->get();
```

**مثال النتيجة:**
```
driver_id=49 → total_requests=5, avg_response=3.00, avg_arrival=8.00
driver_id=50 → total_requests=3, avg_response=5.00, avg_arrival=12.00
driver_id=51 → total_requests=2, avg_response=2.00, avg_arrival=6.00
```

### الخطوة 2: حساب المقاييس

```php
    $reports = $results->map(function ($row) use ($month) {
        // ↑ map → بتمشي على كل صف وتعمل حسابات

        $avgResponse = (float) $row->avg_response_time;   // مثلاً: 3.00
        $avgArrival  = (float) $row->avg_arrival_time;     // مثلاً: 8.00
        $efficiency  = round($avgResponse + $avgArrival, 2);
        // ↑ الكفاءة = 3 + 8 = 11.00
        //   أقل = أحسن (يعني السائق سريع)

        $score = round($row->total_requests / ($avgResponse + $avgArrival + 1), 4);
        // ↑ النتيجة = 5 / (3 + 8 + 1) = 5 / 12 = 0.4167
        //   +1 عشان لو المتوسطات = 0 منقسمش على صفر
        //   أعلى = أحسن

        return [
            'driver_id' => $row->driver_id,
            'month' => $month,
            'total_requests' => $row->total_requests,
            'avg_response_time' => $avgResponse,
            'avg_arrival_time' => $avgArrival,
            'efficiency' => $efficiency,
            'performance_score' => $score,
        ];
    });
```

### الخطوة 3: الترتيب

```php
    $reports = $reports->sortByDesc('performance_score')->values();
    // ↑ بيرتب السواقين من الأعلى نتيجة للأقل
    //   values() → بيعيد ترقيم الـ index من 0

    $totalDrivers = $reports->count();
    // ↑ عدد السواقين (مثلاً 3)
```

### الخطوة 4: الحالة والحفظ

```php
    foreach ($reports as $index => $report) {
        $ranking = $index + 1;
        // ↑ أول واحد ranking = 1 (الأحسن)

        // تحديد الحالة بناءً على الترتيب:
        if ($ranking <= ceil($totalDrivers * 0.25)) {
            $status = 'HIGH';
            // ↑ أحسن 25% → مثلاً لو 8 سواقين: أول 2
            //   ceil() → بيقرّب لأعلى (0.25 * 8 = 2)
        } elseif ($ranking <= ceil($totalDrivers * 0.75)) {
            $status = 'MEDIUM';
            // ↑ الوسط 50% → من 3 لحد 6
        } else {
            $status = 'LOW';
            // ↑ أسوأ 25% → آخر 2
        }

        DB::table('driver_monthly_reports')->updateOrInsert(
            // ↑ updateOrInsert → لو فيه سطر بنفس القيم دي: حدّثه
            //                    لو مفيش: اعمل سطر جديد
            [
                'driver_id' => $report['driver_id'],
                'month'     => $month,
            ],
            // ↑ الشرط: نفس السائق ونفس الشهر
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
            // ↑ البيانات اللي بتتحفظ أو بتتحدث
        );
    }
```

---

## 📁 ملف 6: Kernel — التسجيل في الـ Scheduler

```
المسار: app/Console/Kernel.php
```

```php
protected function schedule(Schedule $schedule): void
{
    $schedule->command('requests:assign-scheduled')->everyMinute();
    // ↑ ده كان موجود قبل كده

    $schedule->command('drivers:calculate-performance')->daily();
    // ↑ ده الجديد
    //   daily() → يعني بيتشغل مرة كل يوم الساعة 00:00
    //   ممكن تغيره:
    //   ->hourly()    ← كل ساعة
    //   ->weekly()    ← كل أسبوع
    //   ->monthly()   ← كل شهر
    //   ->dailyAt('03:00') ← كل يوم الساعة 3 الفجر
}
```

---

## 📁 ملف 7: DriverReportController — API الريبورت

```
المسار: app/Http/Controllers/Api/V1/DriverReportController.php
```

```php
public function show($driverId)
// ↑ الدالة بتاخد رقم السائق من الـ URL
//   مثال: GET /api/v1/driver-report/49 → $driverId = 49
{
    $month = now()->format('Y-m');
    // ↑ الشهر الحالي — مثال: "2026-04"

    // جلب بيانات السائق:
    $driver = DB::table('drivers')
        ->select('id', 'name', 'phone', 'email')
        ->where('id', $driverId)
        ->first();
    // ↑ بيجيب سطر واحد من جدول drivers
    //   first() → أول نتيجة بس (مش كلهم)

    // جلب الملخص الشهري:
    $summary = DB::table('driver_monthly_reports')
        ->where('driver_id', $driverId)
        ->where('month', $month)
        ->first();
    // ↑ بيجيب التقرير الشهري للسائق ده
    //   لو مفيش (لسه مشتغلش الـ command) → بيرجع null

    // جلب تفاصيل كل طلب:
    $requests = DB::table('requests')
        ->select(
            'id',
            'request_type',
            'created_at',
            'accepted_at',
            'arrived_at',
            DB::raw('TIMESTAMPDIFF(MINUTE, created_at, accepted_at) as response_time'),
            // ↑ بيحسب الفرق بالدقايق بين الإنشاء والقبول لكل طلب
            DB::raw('TIMESTAMPDIFF(MINUTE, accepted_at, arrived_at) as arrival_time'),
            // ↑ بيحسب الفرق بالدقايق بين القبول والوصول
            DB::raw('TIMESTAMPDIFF(MINUTE, created_at, arrived_at) as total_time')
            // ↑ الوقت الكلي من الإنشاء للوصول
        )
        ->where('driver_id', $driverId)        // ← بس الطلبات بتاعت السائق ده
        ->where('status', 'completed')         // ← بس المكتملة
        ->whereNotNull('accepted_at')          // ← لازم يكون اتقبل
        ->whereNotNull('arrived_at')           // ← لازم يكون وصل
        ->whereBetween('created_at', [...])    // ← في الشهر ده بس
        ->orderBy('created_at', 'desc')        // ← الأحدث الأول
        ->get();

    // بناء الـ response:
    return response()->json([
        'status' => true,
        'data' => [
            'report_title' => 'تقرير أداء السائق الشهري',
            'month' => $month,
            'driver' => [...],       // ← بيانات السائق
            'summary' => [...],      // ← الملخص (من driver_monthly_reports)
            'requests' => [...],     // ← كل طلب بتفاصيله
            'total_completed' => $requests->count(),   // ← عدد الطلبات
        ],
    ]);
}
```

---

## 📁 ملف 8: web.php — Route صفحة الورقة

```
المسار: routes/web.php
```

```php
Route::get('/report/driver/{id}', function ($id) {
    // ↑ لما حد يفتح http://127.0.0.1:8000/report/driver/49
    //   الـ {id} بتتحول لـ $id = 49

    // ... (نفس كود جلب البيانات زي الـ API)

    return view('reports.driver-performance', compact('driver', 'summary', 'requests', 'month'));
    // ↑ view() → بتفتح ملف Blade وبتبعتله البيانات
    //   'reports.driver-performance' → ده الملف:
    //   resources/views/reports/driver-performance.blade.php
    //
    //   compact() → بتعمل array من المتغيرات
    //   يعني: ['driver' => $driver, 'summary' => $summary, ...]
});
```

---

## 📁 ملف 9: Blade View — صفحة الريبورت

```
المسار: resources/views/reports/driver-performance.blade.php
```

### أهم أجزاء الكود:

```html
<!-- عرض اسم السائق -->
{{ $driver->name }}
<!-- ↑ {{ }} → بتطبع القيمة في الصفحة -->
<!-- $driver جاي من الـ route — view() بعتته -->

<!-- عرض عدد الطلبات من الملخص -->
{{ $summary->total_requests }}
<!-- ↑ بيجيب القيمة من جدول driver_monthly_reports -->

<!-- لو فيه ملخص اعرضه، لو مفيش اعرض رسالة -->
@if($summary)
    <!-- اعرض الكروت والجداول -->
@else
    لا يوجد ملخص لهذا الشهر
@endif

<!-- عرض كل طلب في جدول -->
@foreach($requests as $index => $r)
<tr>
    <td>{{ $index + 1 }}</td>          <!-- رقم مسلسل -->
    <td>{{ $r->id }}</td>              <!-- رقم الطلب -->
    <td>{{ $r->response_time }}</td>   <!-- وقت القبول بالدقايق -->
    <td>{{ $r->arrival_time }}</td>    <!-- وقت الوصول بالدقايق -->
    <td>{{ $r->total_time }}</td>      <!-- الوقت الكلي -->
</tr>
@endforeach

<!-- زرار الطباعة -->
<button onclick="window.print()">طباعة / حفظ PDF</button>
<!-- ↑ window.print() → بيفتح نافذة الطباعة في المتصفح -->
<!-- من هناك تختار "Save as PDF" -->
```

### أسلوب الطباعة:

```css
@media print {
    .print-btn { display: none; }
    /* ↑ لما تطبع → الزرار يختفي (مش عايزينه في الورقة) */

    .page { box-shadow: none; }
    /* ↑ الظل يختفي في الورقة المطبوعة */
}
```

---

## 📁 ملف 10: Grafana Queries

```
المسار: api-docs/grafana_queries.sql
```

### مثال — الكويري الأول:

```sql
SELECT
    r.driver_id,                    -- رقم السائق
    d.name AS driver_name,          -- اسم السائق (من جدول drivers)
    r.total_requests,               -- عدد الطلبات
    r.avg_response_time,            -- متوسط وقت القبول
    r.avg_arrival_time,             -- متوسط وقت الوصول
    r.efficiency,                   -- الكفاءة
    r.performance_score,            -- نقاط الأداء
    r.ranking,                      -- الترتيب
    r.status                        -- الحالة (HIGH/MEDIUM/LOW)
FROM driver_monthly_reports r
-- ↑ r = اختصار لاسم الجدول
JOIN drivers d ON d.id = r.driver_id
-- ↑ JOIN → بيربط جدول التقارير بجدول السواقين عشان نجيب الاسم
--   الشرط: d.id = r.driver_id (نفس رقم السائق)
WHERE r.month = '2026-04'
-- ↑ بس الشهر ده
ORDER BY r.performance_score DESC;
-- ↑ من الأعلى نتيجة للأقل
```

### Pie Chart بالألوان:

```sql
SELECT
    status,                              -- HIGH أو MEDIUM أو LOW
    COUNT(*) AS driver_count,            -- عدد السواقين في كل حالة
    CASE status
        WHEN 'HIGH'   THEN '#22c55e'     -- أخضر
        WHEN 'MEDIUM' THEN '#f59e0b'     -- برتقالي
        WHEN 'LOW'    THEN '#ef4444'     -- أحمر
    END AS color
    -- ↑ CASE = لو الحالة HIGH اديلها أخضر، لو MEDIUM اديلها برتقالي...
FROM driver_monthly_reports
WHERE month = '2026-04'
GROUP BY status
-- ↑ بيجمّع بالحالة — يعني صف واحد لكل حالة
ORDER BY FIELD(status, 'HIGH', 'MEDIUM', 'LOW');
-- ↑ بيرتب: HIGH أول حاجة، بعدين MEDIUM، بعدين LOW
```

---

## 🧮 المعادلات بالأمثلة

### مثال عملي:

سائق اسمه أحمد عمل 3 طلبات في شهر أبريل:

| الطلب | created_at | accepted_at | arrived_at | وقت القبول | وقت الوصول |
|---|---|---|---|---|---|
| #1 | 10:00 | 10:02 | 10:10 | 2 دق | 8 دق |
| #2 | 14:00 | 14:05 | 14:15 | 5 دق | 10 دق |
| #3 | 18:00 | 18:01 | 18:07 | 1 دق | 6 دق |

**الحسابات:**
```
total_requests    = 3
avg_response_time = (2 + 5 + 1) / 3 = 2.67 دقيقة
avg_arrival_time  = (8 + 10 + 6) / 3 = 8.00 دقيقة
efficiency        = 2.67 + 8.00 = 10.67 دقيقة
performance_score = 3 / (2.67 + 8.00 + 1) = 3 / 11.67 = 0.2571
```

**لو فيه سائق تاني اسمه محمد نتيجته 0.15:**
```
أحمد → ranking = 1, status = HIGH  🟢
محمد → ranking = 2, status = LOW   🔴
```
