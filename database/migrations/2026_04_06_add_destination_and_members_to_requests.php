<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('requests', function (Blueprint $table) {
            $table->decimal('destination_latitude', 10, 8)->nullable()->after('pickup_longitude');
            $table->decimal('destination_longitude', 11, 8)->nullable()->after('destination_latitude');
            $table->unsignedInteger('members_count')->default(1)->after('scheduled_time');
        });
    }

    public function down(): void
    {
        Schema::table('requests', function (Blueprint $table) {
            $table->dropColumn(['destination_latitude', 'destination_longitude', 'members_count']);
        });
    }
};
