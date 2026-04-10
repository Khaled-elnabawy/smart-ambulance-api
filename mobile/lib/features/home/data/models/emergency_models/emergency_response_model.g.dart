// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyResponseModel _$EmergencyResponseModelFromJson(
  Map<String, dynamic> json,
) => EmergencyResponseModel(
  message: json['message'] as String?,
  status: json['status'] as bool?,
  code: (json['status_code'] as num?)?.toInt(),
  data: json['data'] == null
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
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      ambulanceId: (json['ambulance_id'] as num?)?.toInt(),
      driverId: (json['driver_id'] as num?)?.toInt(),
      requestType: json['request_type'] as String?,
      status: json['status'] as String?,
      pickup_Latitude: json['pickup_latitude'] as String?,
      pickupLongitude: json['pickup_longitude'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
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
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
