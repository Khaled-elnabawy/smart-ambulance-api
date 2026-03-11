<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class AddStatusCodeToResponse
{
    /**
     * Add HTTP status code to JSON response body.
     */
    public function handle(Request $request, Closure $next)
    {
        $response = $next($request);

        if ($response instanceof JsonResponse) {
            $data = $response->getData(true);
            $data['status_code'] = $response->getStatusCode();
            $response->setData($data);
        }

        return $response;
    }
}
