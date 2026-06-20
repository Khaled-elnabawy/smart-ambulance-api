<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Driver;
use App\Mail\ResetCodeMail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Validation\ValidationException;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    public function userRegister(Request $request)
    {
        try {
            $validated = $request->validate([
                'name' => 'required|string|max:255',
                'phone' => 'required|string|max:20',
                'national_id' => 'required|digits:14|unique:users,national_id',
                'email' => 'required|string|email|max:255|unique:users',
                'password' => 'required|string|min:8',
                'confirm_password' => 'required|string|same:password',
            ]);

            // Cross-table check: ensure email is not used by a driver
            if (Driver::where('email', $validated['email'])->exists()) {
                return response()->json([
                    'status' => false,
                    'message' => 'Email already used by a driver',
                ], Response::HTTP_CONFLICT);
            }

            $user = User::create([
                'name' => $validated['name'],
                'phone' => $validated['phone'],
                'national_id' => $validated['national_id'],
                'email' => $validated['email'],
                'password' => Hash::make($validated['password']),
            ]);

            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'status' => true,
                'message' => 'User registered successfully',
                'data' => [
                    'user' => $user,
                    'token' => $token,
                    'user_type' => 'user',
                    'rating' => null,
                ],
            ], Response::HTTP_CREATED);
        } catch (ValidationException $e) {
            return response()->json([
                'status' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }
    }

    /**
     * Unified Login (User or Driver)
     * POST /api/v1/login
     * Body: { "email": "...", "password": "..." }
     *
     * Searches users table first, then drivers table.
     * Returns user_type to identify the account type.
     */
    public function login(Request $request)
    {
        try {
            $validated = $request->validate([
                'email' => 'required|string|email',
                'password' => 'required|string',
            ]);

            // Step 1: Search in users table
            $user = User::where('email', $validated['email'])->first();

            if ($user && Hash::check($validated['password'], $user->password)) {
                $token = $user->createToken('auth_token')->plainTextToken;

                return response()->json([
                    'status' => true,
                    'message' => 'Login successful',
                    'data' => [
                        'id' => $user->id,
                        'name' => $user->name,
                        'email' => $user->email,
                        'phone' => $user->phone,
                        'token' => $token,
                        'user_type' => 'user',
                        'rating' => null,
                    ],
                ], Response::HTTP_OK);
            }

            // Step 2: Search in drivers table
            $driver = Driver::where('email', $validated['email'])->first();

            if ($driver && Hash::check($validated['password'], $driver->password)) {
                $token = $driver->createToken('auth_token')->plainTextToken;

                // Calculate driver's average rating
                $avgRating = DB::table('ratings')
                    ->where('driver_id', $driver->id)
                    ->avg('rating');

                return response()->json([
                    'status' => true,
                    'message' => 'Login successful',
                    'data' => [
                        'id' => $driver->id,
                        'name' => $driver->name,
                        'email' => $driver->email,
                        'phone' => $driver->phone,
                        'token' => $token,
                        'user_type' => 'driver',
                        'rating' => $avgRating ? round((float) $avgRating, 2) : null,
                    ],
                ], Response::HTTP_OK);
            }

            // Step 3: Not found in both tables
            return response()->json([
                'status' => false,
                'message' => 'Invalid credentials',
            ], Response::HTTP_UNAUTHORIZED);

        } catch (ValidationException $e) {
            return response()->json([
                'status' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }
    }

    public function logout(Request $request)
    {
        try {
            $request->user()->currentAccessToken()->delete();

            return response()->json([
                'status' => true,
                'message' => 'Logout successful',
            ], Response::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Logout failed',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function forgotPassword(Request $request)
    {
        try {
            $validated = $request->validate([
                'email' => 'required|string|email',
            ]);

            $user = User::where('email', $validated['email'])->first();

            if (!$user) {
                return response()->json([
                    'status' => false,
                    'message' => 'Email not found',
                ], Response::HTTP_NOT_FOUND);
            }

            // Generate 6-digit reset code
            $code = rand(100000, 999999);

            // Delete existing codes for this email
            DB::table('password_resets')->where('email', $validated['email'])->delete();

            // Store new code
            DB::table('password_resets')->insert([
                'email' => $validated['email'],
                'token' => $code,
                'created_at' => now(),
            ]);

            // Send the code via email
            Mail::to($validated['email'])->send(new ResetCodeMail($code));

            return response()->json([
                'status' => true,
                'message' => 'Reset code sent to your email',
            ], Response::HTTP_OK);
        } catch (ValidationException $e) {
            return response()->json([
                'status' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Failed to send reset code. Please try again later.',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function verifyResetCode(Request $request)
    {
        try {
            $validated = $request->validate([
                'email' => 'required|string|email',
                'code' => 'required|string',
            ]);

            // Check if code is valid
            $resetRecord = DB::table('password_resets')
                ->where('email', $validated['email'])
                ->where('token', $validated['code'])
                ->first();

            if (!$resetRecord) {
                return response()->json([
                    'status' => false,
                    'message' => 'Invalid reset code',
                ], Response::HTTP_UNAUTHORIZED);
            }

            // Check if code is not older than 10 minutes
            if (now()->diffInMinutes($resetRecord->created_at) > 10) {
                DB::table('password_resets')
                    ->where('email', $validated['email'])
                    ->delete();

                return response()->json([
                    'status' => false,
                    'message' => 'Reset code has expired',
                ], Response::HTTP_UNAUTHORIZED);
            }

            // Code is valid - generate a reset token for the password change step
            $resetToken = Str::random(60);

            // Replace the code with the reset token
            DB::table('password_resets')
                ->where('email', $validated['email'])
                ->update([
                    'token' => $resetToken,
                    'created_at' => now(),
                ]);

            return response()->json([
                'status' => true,
                'message' => 'Code verified successfully',
                'data' => [
                    'reset_token' => $resetToken,
                ],
            ], Response::HTTP_OK);
        } catch (ValidationException $e) {
            return response()->json([
                'status' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }
    }

    public function resetPassword(Request $request)
    {
        try {
            $validated = $request->validate([
                'token' => 'required|string',
                'password' => 'required|string|min:8',
                'confirm_password' => 'required|string|same:password',
            ]);

            // Check if token is valid
            $resetRecord = DB::table('password_resets')
                ->where('token', $validated['token'])
                ->first();

            if (!$resetRecord) {
                return response()->json([
                    'status' => false,
                    'message' => 'Invalid or expired reset token',
                ], Response::HTTP_UNAUTHORIZED);
            }

            // Check if token is not older than 1 hour
            if (now()->diffInMinutes($resetRecord->created_at) > 60) {
                DB::table('password_resets')
                    ->where('email', $resetRecord->email)
                    ->delete();

                return response()->json([
                    'status' => false,
                    'message' => 'Reset token has expired',
                ], Response::HTTP_UNAUTHORIZED);
            }

            // Update password
            $user = User::where('email', $resetRecord->email)->first();

            if (!$user) {
                return response()->json([
                    'status' => false,
                    'message' => 'User not found',
                ], Response::HTTP_NOT_FOUND);
            }

            $user->update([
                'password' => Hash::make($validated['password']),
            ]);

            // Delete the reset token
            DB::table('password_resets')
                ->where('email', $resetRecord->email)
                ->delete();

            return response()->json([
                'status' => true,
                'message' => 'Password reset successfully',
            ], Response::HTTP_OK);
        } catch (ValidationException $e) {
            return response()->json([
                'status' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }
    }
}
