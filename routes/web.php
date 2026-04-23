<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\V1\DriverReportController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

Route::get('/', function () {
    return view('welcome');
});

// Driver Performance Report (Printable Page)
Route::get('/report/driver/{id}', [DriverReportController::class, 'printable']);
