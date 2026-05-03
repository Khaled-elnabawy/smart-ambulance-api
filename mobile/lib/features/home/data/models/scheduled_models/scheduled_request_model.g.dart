// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledRequestModel _$ScheduledRequestModelFromJson(
  Map<String, dynamic> json,
) => ScheduledRequestModel(
  requestType: json['request_type'] as String,
  pickupLatitude: (json['pickup_latitude'] as num).toDouble(),
  pickupLongitude: (json['pickup_longitude'] as num).toDouble(),
  destinationLatitude: (json['destination_latitude'] as num).toDouble(),
  destinationLongitude: (json['destination_longitude'] as num).toDouble(),
  scheduledTime: json['scheduled_time'] as String,
  membersCount: (json['members_count'] as num).toInt(),
);

Map<String, dynamic> _$ScheduledRequestModelToJson(
  ScheduledRequestModel instance,
) => <String, dynamic>{
  'request_type': instance.requestType,
  'pickup_latitude': instance.pickupLatitude,
  'pickup_longitude': instance.pickupLongitude,
  'destination_latitude': instance.destinationLatitude,
  'destination_longitude': instance.destinationLongitude,
  'scheduled_time': instance.scheduledTime,
  'members_count': instance.membersCount,
};
