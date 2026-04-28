import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_location_response.g.dart';

@JsonSerializable()
class UpdateLocationResponse {
  final bool? status;
  final String? message;
  @JsonKey(name: 'status_code')
  final int? statusCode;

  UpdateLocationResponse({this.status, this.message, this.statusCode});

  factory UpdateLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateLocationResponseFromJson(json);
}
