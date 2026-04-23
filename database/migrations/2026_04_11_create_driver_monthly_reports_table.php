<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('driver_monthly_reports', function (Blueprint $table) {
            $table->id();

            $table->foreignId('driver_id')
                  ->constrained()
                  ->cascadeOnDelete();

            $table->char('month', 7);

            $table->unsignedInteger('total_requests')->default(0);
            $table->decimal('avg_response_time', 10, 2)->default(0);
            $table->decimal('avg_arrival_time', 10, 2)->default(0);
            $table->decimal('efficiency', 10, 2)->default(0);
            $table->decimal('performance_score', 10, 4)->default(0);
            $table->unsignedInteger('ranking')->default(0);
            $table->enum('status', ['HIGH', 'MEDIUM', 'LOW'])->default('MEDIUM');

            $table->timestamp('created_at')->nullable();

            $table->unique(['driver_id', 'month']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('driver_monthly_reports');
    }
};
