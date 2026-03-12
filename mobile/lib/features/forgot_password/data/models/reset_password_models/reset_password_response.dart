import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  String? message;
  bool? status;
  @JsonKey(name: 'status_code')
  int? code;

  ResetPasswordResponse({this.message, this.status, this.code});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);
}
