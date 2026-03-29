// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directions_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectionsRequestModel _$DirectionsRequestModelFromJson(
  Map<String, dynamic> json,
) => DirectionsRequestModel(
  origin: LocationWrapper.fromJson(json['origin'] as Map<String, dynamic>),
  destination: LocationWrapper.fromJson(
    json['destination'] as Map<String, dynamic>,
  ),
  travelMode: json['travelMode'] as String? ?? "DRIVE",
  routingPreference: json['routingPreference'] as String?,
  computeAlternativeRoutes: json['computeAlternativeRoutes'] as bool?,
  routeModifiers: json['routeModifiers'] == null
      ? null
      : RouteModifiers.fromJson(json['routeModifiers'] as Map<String, dynamic>),
  languageCode: json['languageCode'] as String?,
  units: json['units'] as String?,
);

Map<String, dynamic> _$DirectionsRequestModelToJson(
  DirectionsRequestModel instance,
) => <String, dynamic>{
  'origin': instance.origin.toJson(),
  'destination': instance.destination.toJson(),
  'travelMode': instance.travelMode,
  'routingPreference': instance.routingPreference,
  'computeAlternativeRoutes': instance.computeAlternativeRoutes,
  'routeModifiers': instance.routeModifiers?.toJson(),
  'languageCode': instance.languageCode,
  'units': instance.units,
};

LocationWrapper _$LocationWrapperFromJson(Map<String, dynamic> json) =>
    LocationWrapper(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationWrapperToJson(LocationWrapper instance) =>
    <String, dynamic>{'location': instance.location.toJson()};

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
  latLng: LatLngModel.fromJson(json['latLng'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
  'latLng': instance.latLng.toJson(),
};

LatLngModel _$LatLngModelFromJson(Map<String, dynamic> json) => LatLngModel(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$LatLngModelToJson(LatLngModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

RouteModifiers _$RouteModifiersFromJson(Map<String, dynamic> json) =>
    RouteModifiers(
      avoidTolls: json['avoidTolls'] as bool?,
      avoidHighways: json['avoidHighways'] as bool?,
      avoidFerries: json['avoidFerries'] as bool?,
    );

Map<String, dynamic> _$RouteModifiersToJson(RouteModifiers instance) =>
    <String, dynamic>{
      'avoidTolls': instance.avoidTolls,
      'avoidHighways': instance.avoidHighways,
      'avoidFerries': instance.avoidFerries,
    };
