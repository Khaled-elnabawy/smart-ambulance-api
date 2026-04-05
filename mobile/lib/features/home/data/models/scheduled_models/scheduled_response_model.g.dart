// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledResponseModel _$ScheduledResponseModelFromJson(
  Map<String, dynamic> json,
) => ScheduledResponseModel(
  json['message'] as String?,
  json['status'] as bool?,
  (json['status_code'] as num?)?.toInt(),
  json['data'] == null
      ? null
      : ScheduledData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ScheduledResponseModelToJson(
  ScheduledResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'status': instance.status,
  'status_code': instance.code,
  'data': instance.data,
};

ScheduledData _$ScheduledDataFromJson(Map<String, dynamic> json) =>
    ScheduledData(
      (json['id'] as num?)?.toInt(),
      (json['user_id'] as num?)?.toInt(),
      (json['ambulance_id'] as num?)?.toInt(),
      (json['driver_id'] as num?)?.toInt(),
      json['request_type'] as String?,
      json['status'] as String?,
      json['pickup_latitude'] as String?,
      json['pickup_longitude'] as String?,
      json['scheduled_time'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['deleted_at'] as String?,
    );

Map<String, dynamic> _$ScheduledDataToJson(ScheduledData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'ambulance_id': instance.ambulanceId,
      'driver_id': instance.driverId,
      'request_type': instance.requestType,
      'status': instance.status,
      'pickup_latitude': instance.pickup_Latitude,
      'pickup_longitude': instance.pickupLongitude,
      'scheduled_time': instance.scheduledTime,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
