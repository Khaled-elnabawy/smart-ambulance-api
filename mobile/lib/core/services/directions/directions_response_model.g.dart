// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directions_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectionsResponseModel _$DirectionsResponseModelFromJson(
  Map<String, dynamic> json,
) => DirectionsResponseModel(
  features: (json['features'] as List<dynamic>)
      .map((e) => Feature.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DirectionsResponseModelToJson(
  DirectionsResponseModel instance,
) => <String, dynamic>{'features': instance.features};

Feature _$FeatureFromJson(Map<String, dynamic> json) => Feature(
  properties: FeatureProperties.fromJson(
    json['properties'] as Map<String, dynamic>,
  ),
  geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FeatureToJson(Feature instance) => <String, dynamic>{
  'properties': instance.properties.toJson(),
  'geometry': instance.geometry.toJson(),
};

FeatureProperties _$FeaturePropertiesFromJson(Map<String, dynamic> json) =>
    FeatureProperties(
      summary: Summary.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeaturePropertiesToJson(FeatureProperties instance) =>
    <String, dynamic>{'summary': instance.summary.toJson()};

Summary _$SummaryFromJson(Map<String, dynamic> json) => Summary(
  distance: (json['distance'] as num).toDouble(),
  duration: (json['duration'] as num).toDouble(),
);

Map<String, dynamic> _$SummaryToJson(Summary instance) => <String, dynamic>{
  'distance': instance.distance,
  'duration': instance.duration,
};

Geometry _$GeometryFromJson(Map<String, dynamic> json) => Geometry(
  coordinates: (json['coordinates'] as List<dynamic>)
      .map(
        (e) => (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
      )
      .toList(),
);

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
  'coordinates': instance.coordinates,
};
