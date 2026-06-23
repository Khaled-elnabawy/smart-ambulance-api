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
        $isScheduled = $this->input('request_type') === 'scheduled';

        return [
            'request_type' => 'required|in:emergency,scheduled',
            'pickup_latitude' => 'required|numeric',
            'pickup_longitude' => 'required|numeric',
            'destination_latitude' => $isScheduled ? 'required|numeric' : 'nullable|numeric',
            'destination_longitude' => $isScheduled ? 'required|numeric' : 'nullable|numeric',
            'destination_name' => $isScheduled ? 'required|string|max:255' : 'nullable|string|max:255',
            'scheduled_time' => $this->getScheduledTimeRules(),
            'members_count' => $isScheduled ? 'required|integer|min:1' : 'nullable|integer|min:1',
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
            'pickup_latitude.required' => 'Pickup latitude is required (From location)',
            'pickup_latitude.numeric' => 'Pickup latitude must be a number',
            'pickup_longitude.required' => 'Pickup longitude is required (From location)',
            'pickup_longitude.numeric' => 'Pickup longitude must be a number',
            'destination_latitude.required' => 'Destination latitude is required (To location)',
            'destination_latitude.numeric' => 'Destination latitude must be a number',
            'destination_longitude.required' => 'Destination longitude is required (To location)',
            'destination_longitude.numeric' => 'Destination longitude must be a number',
            'scheduled_time.required' => 'Scheduled time is required for scheduled requests',
            'scheduled_time.date_format' => 'Scheduled time must be in format: YYYY-MM-DD HH:MM:SS',
            'scheduled_time.after' => 'Scheduled time must be in the future',
            'members_count.required' => 'Number of members is required for scheduled requests',
            'members_count.integer' => 'Number of members must be a whole number',
            'members_count.min' => 'Number of members must be at least 1',
        ];
    }
}
