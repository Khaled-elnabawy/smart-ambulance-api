<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('drivers', function (Blueprint $table) {
            // Modify the status enum to include 'pending'
            // Change from: offline, available, busy
            // To: offline, available, pending, busy
            $table->enum('status', ['offline', 'available', 'pending', 'busy'])
                ->default('offline')
                ->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('drivers', function (Blueprint $table) {
            // Revert back to original enum
            $table->enum('status', ['offline', 'available', 'busy'])
                ->default('offline')
                ->change();
        });
    }
};
