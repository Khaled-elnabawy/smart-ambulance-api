// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyRequestModel _$EmergencyRequestModelFromJson(
  Map<String, dynamic> json,
) => EmergencyRequestModel(
  requestType: json['request_type'] as String,
  pickupLatitude: (json['pickup_latitude'] as num).toDouble(),
  pickupLongitude: (json['pickup_longitude'] as num).toDouble(),
);

Map<String, dynamic> _$EmergencyRequestModelToJson(
  EmergencyRequestModel instance,
) => <String, dynamic>{
  'request_type': instance.requestType,
  'pickup_latitude': instance.pickupLatitude,
  'pickup_longitude': instance.pickupLongitude,
};
