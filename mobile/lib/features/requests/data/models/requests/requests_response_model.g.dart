// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestsResponseModel _$RequestsResponseModelFromJson(
  Map<String, dynamic> json,
) => RequestsResponseModel(
  status: json['status'] as bool?,
  statusCode: (json['status_code'] as num?)?.toInt(),
  requests: (json['data'] as List<dynamic>?)
      ?.map((e) => Request.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RequestsResponseModelToJson(
  RequestsResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'data': instance.requests,
};

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
  id: (json['id'] as num?)?.toInt(),
  requestType: json['request_type'] as String?,
  status: json['status'] as String?,
  pickupLatitude: json['pickup_latitude'] as String?,
  pickupLongitude: json['pickup_longitude'] as String?,
  destinationLatitude: json['destination_latitude'] as String?,
  destinationLongitude: json['destination_longitude'] as String?,
  scheduledTime: json['scheduled_time'] as String?,
  membersCount: (json['members_count'] as num?)?.toInt(),
  driverId: (json['driver_id'] as num?)?.toInt(),
  userId: (json['user_id'] as num?)?.toInt(),
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
  'id': instance.id,
  'request_type': instance.requestType,
  'status': instance.status,
  'pickup_latitude': instance.pickupLatitude,
  'pickup_longitude': instance.pickupLongitude,
  'destination_latitude': instance.destinationLatitude,
  'destination_longitude': instance.destinationLongitude,
  'scheduled_time': instance.scheduledTime,
  'members_count': instance.membersCount,
  'driver_id': instance.driverId,
  'user_id': instance.userId,
  'created_at': instance.createdAt,
};
