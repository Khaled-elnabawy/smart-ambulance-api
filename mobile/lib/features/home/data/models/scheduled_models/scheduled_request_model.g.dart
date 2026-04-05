// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledRequestModel _$ScheduledRequestModelFromJson(
  Map<String, dynamic> json,
) => ScheduledRequestModel(
  json['request_type'] as String,
  (json['pickup_latitude'] as num).toDouble(),
  (json['pickup_longitude'] as num).toDouble(),
  json['scheduled_time'] as String,
);

Map<String, dynamic> _$ScheduledRequestModelToJson(
  ScheduledRequestModel instance,
) => <String, dynamic>{
  'request_type': instance.requestType,
  'pickup_latitude': instance.pickupLatitude,
  'pickup_longitude': instance.pickupLongitude,
  'scheduled_time': instance.scheduledTime,
};
