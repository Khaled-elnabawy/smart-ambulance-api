// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyResponseModel _$EmergencyResponseModelFromJson(
  Map<String, dynamic> json,
) => EmergencyResponseModel(
  json['message'] as String?,
  json['status'] as bool?,
  (json['status_code'] as num?)?.toInt(),
  json['data'] == null
      ? null
      : EmergencyData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EmergencyResponseModelToJson(
  EmergencyResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'status': instance.status,
  'status_code': instance.code,
  'data': instance.data,
};

EmergencyData _$EmergencyDataFromJson(Map<String, dynamic> json) =>
    EmergencyData(
      (json['id'] as num?)?.toInt(),
      (json['user_id'] as num?)?.toInt(),
      (json['ambulance_id'] as num?)?.toInt(),
      (json['driver_id'] as num?)?.toInt(),
      json['request_type'] as String?,
      json['status'] as String?,
      json['pickup_latitude'] as String?,
      json['pickup_longitude'] as String?,
      json['created_at'] as String?,
      json['deleted_at'] as String?,
    );

Map<String, dynamic> _$EmergencyDataToJson(EmergencyData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'ambulance_id': instance.ambulanceId,
      'driver_id': instance.driverId,
      'request_type': instance.requestType,
      'status': instance.status,
      'pickup_latitude': instance.pickup_Latitude,
      'pickup_longitude': instance.pickupLongitude,
      'created_at': instance.createdAt,
      'deleted_at': instance.deletedAt,
    };
