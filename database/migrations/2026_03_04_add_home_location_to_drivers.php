<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('drivers', function (Blueprint $table) {
            $table->decimal('home_latitude', 10, 8)->nullable()->after('last_longitude');
            $table->decimal('home_longitude', 11, 8)->nullable()->after('home_latitude');
        });
    }

    public function down(): void
    {
        Schema::table('drivers', function (Blueprint $table) {
            $table->dropColumn(['home_latitude', 'home_longitude']);
        });
    }
};
