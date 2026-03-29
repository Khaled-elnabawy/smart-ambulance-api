// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directions_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectionsResponseModel _$DirectionsResponseModelFromJson(
  Map<String, dynamic> json,
) => DirectionsResponseModel(
  routes: (json['routes'] as List<dynamic>)
      .map((e) => RouteModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DirectionsResponseModelToJson(
  DirectionsResponseModel instance,
) => <String, dynamic>{'routes': instance.routes};

RouteModel _$RouteModelFromJson(Map<String, dynamic> json) => RouteModel(
  distanceMeters: (json['distanceMeters'] as num).toInt(),
  duration: json['duration'] as String,
  polyline: PolylineModel.fromJson(json['polyline'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RouteModelToJson(RouteModel instance) =>
    <String, dynamic>{
      'distanceMeters': instance.distanceMeters,
      'duration': instance.duration,
      'polyline': instance.polyline,
    };

PolylineModel _$PolylineModelFromJson(Map<String, dynamic> json) =>
    PolylineModel(encodedPolyline: json['encodedPolyline'] as String);

Map<String, dynamic> _$PolylineModelToJson(PolylineModel instance) =>
    <String, dynamic>{'encodedPolyline': instance.encodedPolyline};
