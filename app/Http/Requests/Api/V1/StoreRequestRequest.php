<?php

namespace App\Http\Requests\Api\V1;

use Illuminate\Foundation\Http\FormRequest;

class StoreRequestRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'request_type' => 'required|in:emergency,scheduled',
            'pickup_latitude' => 'required|numeric',
            'pickup_longitude' => 'required|numeric',
            'scheduled_time' => $this->getScheduledTimeRules(),
        ];
    }

    private function getScheduledTimeRules(): string|array
    {
        if ($this->input('request_type') === 'scheduled') {
            return 'required|date_format:Y-m-d H:i:s|after:now';
        }

        return 'nullable';
    }

    public function messages(): array
    {
        return [
            'request_type.required' => 'Request type is required',
            'request_type.in' => 'Request type must be emergency or scheduled',
            'pickup_latitude.required' => 'Pickup latitude is required',
            'pickup_latitude.numeric' => 'Pickup latitude must be a number',
            'pickup_longitude.required' => 'Pickup longitude is required',
            'pickup_longitude.numeric' => 'Pickup longitude must be a number',
            'scheduled_time.required' => 'Scheduled time is required for scheduled requests',
            'scheduled_time.date_format' => 'Scheduled time must be in format: YYYY-MM-DD HH:MM:SS',
            'scheduled_time.after' => 'Scheduled time must be in the future',
        ];
    }
}
