<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\RequestController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::prefix('v1')->group(function () {

    // Authentication Routes (Public)
    Route::post('/register', [AuthController::class, 'userRegister']);
    Route::post('/login', [AuthController::class, 'userLogin']);
    Route::post('/driver/login', [AuthController::class, 'driverLogin']);

    // Protected Routes
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::get('/user', function (Request $request) {
            return response()->json([
                'status' => true,
                'data' => $request->user(),
            ]);
        });

        // Request Management
        Route::post('/requests', [RequestController::class, 'store']);
        Route::post('/requests/{id}/accept', [RequestController::class, 'accept']);
        Route::post('/requests/{id}/reject', [RequestController::class, 'reject']);
        Route::post('/requests/{id}/arrived', [RequestController::class, 'arrived']);
        Route::post('/requests/{id}/completed', [RequestController::class, 'completed']);
    });

    // Public Test Route
    Route::get('/test', function () {
        return response()->json([
            'status' => true,
            'message' => 'Smart Ambulance API v1 Is Working'
        ]);
    });

});
