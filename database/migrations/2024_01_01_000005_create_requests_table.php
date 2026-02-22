<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('requests', function (Blueprint $table) {

            $table->id();

            $table->foreignId('user_id')
                  ->constrained()
                  ->cascadeOnDelete();

            $table->foreignId('ambulance_id')
                  ->nullable()
                  ->constrained()
                  ->nullOnDelete();

            $table->foreignId('driver_id')
                  ->nullable()
                  ->constrained()
                  ->nullOnDelete();

            $table->enum('request_type', ['emergency', 'scheduled']);

            $table->enum('status', [
                'pending',
                'in_progress',
                'arrived',
                'completed',
                'cancelled'
            ])->default('pending');

            $table->decimal('pickup_latitude', 10, 8);
            $table->decimal('pickup_longitude', 11, 8);

            $table->timestamp('scheduled_time')->nullable();

            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('requests');
    }
};