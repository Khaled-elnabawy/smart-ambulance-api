import 'package:json_annotation/json_annotation.dart';

part 'directions_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DirectionsRequestModel {
  final LocationWrapper origin;
  final LocationWrapper destination;
  final String travelMode;
  final String? routingPreference;
  final bool? computeAlternativeRoutes;
  final RouteModifiers? routeModifiers;
  final String? languageCode;
  final String? units;

  DirectionsRequestModel({
    required this.origin,
    required this.destination,
    this.travelMode = "DRIVE",
    this.routingPreference,
    this.computeAlternativeRoutes,
    this.routeModifiers,
    this.languageCode,
    this.units,
  });

  factory DirectionsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$DirectionsRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$DirectionsRequestModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LocationWrapper {
  final Location location;

  LocationWrapper({required this.location});

  factory LocationWrapper.fromJson(Map<String, dynamic> json) =>
      _$LocationWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$LocationWrapperToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Location {
  final LatLngModel latLng;

  Location({required this.latLng});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class LatLngModel {
  final double latitude;
  final double longitude;

  LatLngModel({required this.latitude, required this.longitude});

  factory LatLngModel.fromJson(Map<String, dynamic> json) =>
      _$LatLngModelFromJson(json);

  Map<String, dynamic> toJson() => _$LatLngModelToJson(this);
}

@JsonSerializable()
class RouteModifiers {
  final bool? avoidTolls;
  final bool? avoidHighways;
  final bool? avoidFerries;

  RouteModifiers({this.avoidTolls, this.avoidHighways, this.avoidFerries});

  factory RouteModifiers.fromJson(Map<String, dynamic> json) =>
      _$RouteModifiersFromJson(json);

  Map<String, dynamic> toJson() => _$RouteModifiersToJson(this);
}
