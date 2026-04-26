import 'package:json_annotation/json_annotation.dart';

part 'confirm_response.g.dart';

@JsonSerializable()
class ConfirmResponse {
  final bool? status;
  final String? message;

  @JsonKey(name: 'status_code')
  final int? statusCode;

  ConfirmResponse({this.status, this.message, this.statusCode});

  factory ConfirmResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmResponseFromJson(json);
}
