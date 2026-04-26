// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackRequestResponse _$TrackRequestResponseFromJson(
  Map<String, dynamic> json,
) => TrackRequestResponse(
  status: json['status'] as bool?,
  data: json['data'] == null
      ? null
      : TrackRequestData.fromJson(json['data'] as Map<String, dynamic>),
  statusCode: (json['status_code'] as num?)?.toInt(),
);

Map<String, dynamic> _$TrackRequestResponseToJson(
  TrackRequestResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'data': instance.data,
  'status_code': instance.statusCode,
};

TrackRequestData _$TrackRequestDataFromJson(Map<String, dynamic> json) =>
    TrackRequestData(
      requestId: (json['request_id'] as num?)?.toInt(),
      status: json['status'] as String?,
      requestType: json['request_type'] as String?,
      pickupLatitude: json['pickup_latitude'] as String?,
      pickupLongitude: json['pickup_longitude'] as String?,
      destinationLatitude: json['destination_latitude'] as String?,
      destinationLongitude: json['destination_longitude'] as String?,
      scheduledTime: json['scheduled_time'] as String?,
      membersCount: (json['members_count'] as num?)?.toInt(),
      driver: json['driver'] == null
          ? null
          : TrackRequestDriver.fromJson(json['driver'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrackRequestDataToJson(TrackRequestData instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'status': instance.status,
      'request_type': instance.requestType,
      'pickup_latitude': instance.pickupLatitude,
      'pickup_longitude': instance.pickupLongitude,
      'destination_latitude': instance.destinationLatitude,
      'destination_longitude': instance.destinationLongitude,
      'scheduled_time': instance.scheduledTime,
      'members_count': instance.membersCount,
      'driver': instance.driver,
    };

TrackRequestDriver _$TrackRequestDriverFromJson(Map<String, dynamic> json) =>
    TrackRequestDriver(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      lastLatitude: json['last_latitude'] as String?,
      lastLongitude: json['last_longitude'] as String?,
    );

Map<String, dynamic> _$TrackRequestDriverToJson(TrackRequestDriver instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'last_latitude': instance.lastLatitude,
      'last_longitude': instance.lastLongitude,
    };
