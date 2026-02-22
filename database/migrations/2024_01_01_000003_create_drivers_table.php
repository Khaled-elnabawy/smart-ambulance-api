<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('drivers', function (Blueprint $table) {

            $table->id();

            $table->foreignId('hospital_id')
                  ->constrained()
                  ->cascadeOnDelete();

            $table->string('name');
            $table->string('phone', 20);
            $table->string('email')->unique();
            $table->string('password');

            $table->enum('status', ['available', 'busy', 'offline'])
                  ->default('offline');

            $table->decimal('last_latitude', 10, 8)->nullable();
            $table->decimal('last_longitude', 11, 8)->nullable();
            $table->timestamp('last_location_update')->nullable();

            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('drivers');
    }
};