// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_location_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLocationBody _$UpdateLocationBodyFromJson(Map<String, dynamic> json) =>
    UpdateLocationBody(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$UpdateLocationBodyToJson(UpdateLocationBody instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
