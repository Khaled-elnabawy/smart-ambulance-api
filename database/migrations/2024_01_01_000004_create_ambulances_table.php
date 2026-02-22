<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ambulances', function (Blueprint $table) {

            $table->id();

            $table->foreignId('hospital_id')
                  ->constrained()
                  ->cascadeOnDelete();

            $table->foreignId('driver_id')
                  ->nullable()
                  ->constrained()
                  ->nullOnDelete();

            $table->string('plate_number', 50)->unique();

            $table->enum('status', ['active', 'inactive', 'maintenance'])
                  ->default('active');

            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ambulances');
    }
};