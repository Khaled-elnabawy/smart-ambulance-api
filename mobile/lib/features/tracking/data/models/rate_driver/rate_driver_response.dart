import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate_driver_response.g.dart';

@JsonSerializable()
class RateDriverResponse {
  final bool? status;
  final String? message;
  final RateDriverData? data;
  @JsonKey(name: 'status_code')
  final int? statusCode;

  RateDriverResponse({this.status, this.message, this.data, this.statusCode});

  factory RateDriverResponse.fromJson(Map<String, dynamic> json) =>
      _$RateDriverResponseFromJson(json);
}

@JsonSerializable()
class RateDriverData {
  final int? rating;
  @JsonKey(name: 'driver_average_rating')
  final int? driverAverageRating;

  RateDriverData({this.rating, this.driverAverageRating});

  factory RateDriverData.fromJson(Map<String, dynamic> json) =>
      _$RateDriverDataFromJson(json);
}
