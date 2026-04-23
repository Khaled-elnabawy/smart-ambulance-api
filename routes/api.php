<?php

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\RequestController;
use App\Http\Controllers\Api\V1\DriverController;
use App\Http\Controllers\Api\V1\DriverReportController;
use App\Http\Controllers\Api\V1\ProfileController;

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
    Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
    Route::post('/verify-reset-code', [AuthController::class, 'verifyResetCode']);
    Route::post('/reset-password', [AuthController::class, 'resetPassword']);

    // Protected Routes
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::get('/profile', [ProfileController::class, 'getProfile']);
        Route::put('/profile/update', [ProfileController::class, 'updateProfile']);
        Route::get('/user', function (Request $request) {
            return response()->json([
                'status' => true,
                'data' => $request->user(),
            ], Response::HTTP_OK);
        });

        // Driver Location
        Route::post('/driver/location', [DriverController::class, 'updateLocation']);

        // Request Management
        Route::get('/my-requests', [RequestController::class, 'myRequests']);
        Route::post('/requests', [RequestController::class, 'store']);
        Route::get('/requests/{id}', [RequestController::class, 'show']);
        Route::post('/requests/accept', [RequestController::class, 'accept']);
        Route::post('/requests/reject', [RequestController::class, 'reject']);
        Route::post('/requests/arrived', [RequestController::class, 'arrived']);
        Route::post('/requests/completed', [RequestController::class, 'completed']);
        Route::post('/requests/cancel', [RequestController::class, 'cancel']);
        Route::post('/requests/rate', [RequestController::class, 'rate']);

        // Driver Performance Reports
        Route::get('/driver-report/{driver_id}', [DriverReportController::class, 'show']);
    });

    // Public Test Route
    Route::get('/test', function () {
        return response()->json([
            'status' => true,
            'message' => 'Smart Ambulance API v1 Is Working'
        ], Response::HTTP_OK);
    });

});
