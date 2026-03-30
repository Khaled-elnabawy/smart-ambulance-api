import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:json_annotation/json_annotation.dart';

part 'directions_response_model.g.dart';

@JsonSerializable()
class DirectionsResponseModel {
  final List<RouteModel> routes;

  DirectionsResponseModel({required this.routes});

  factory DirectionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DirectionsResponseModelFromJson(json);
}

@JsonSerializable()
class RouteModel {
  final int distanceMeters;
  final String duration;
  final PolylineModel polyline;

  int get durationInSeconds => int.parse(duration.replaceAll('s', ''));

  RouteModel({
    required this.distanceMeters,
    required this.duration,
    required this.polyline,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);
}

@JsonSerializable()
class PolylineModel {
  final String encodedPolyline;

  PolylineModel({required this.encodedPolyline});

  factory PolylineModel.fromJson(Map<String, dynamic> json) =>
      _$PolylineModelFromJson(json);
}
