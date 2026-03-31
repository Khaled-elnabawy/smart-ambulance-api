import 'package:json_annotation/json_annotation.dart';

part 'directions_response_model.g.dart';

@JsonSerializable()
class DirectionsResponseModel {
  final List<Feature> features;

  DirectionsResponseModel({required this.features});

  factory DirectionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DirectionsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DirectionsResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Feature {
  final FeatureProperties properties;
  final Geometry geometry;

  Feature({required this.properties, required this.geometry});

  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FeatureProperties {
  final Summary summary;

  FeatureProperties({required this.summary});

  factory FeatureProperties.fromJson(Map<String, dynamic> json) =>
      _$FeaturePropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$FeaturePropertiesToJson(this);
}

@JsonSerializable()
class Summary {
  final double distance;
  final double duration;

  Summary({required this.distance, required this.duration});

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryToJson(this);
}

@JsonSerializable()
class Geometry {
  final List<List<double>> coordinates;

  Geometry({required this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}
