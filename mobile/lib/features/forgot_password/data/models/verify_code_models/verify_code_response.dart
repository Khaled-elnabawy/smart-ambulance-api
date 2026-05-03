import 'package:json_annotation/json_annotation.dart';

part 'verify_code_response.g.dart';

@JsonSerializable()
class VerifyCodeResponse {
  final String? message;
  final Data? data;
  final bool? status;
  @JsonKey(name: 'status_code')
  final int? code;

  VerifyCodeResponse({this.message, this.data, this.status, this.code});

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeResponseFromJson(json);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'reset_token')
  final String? resetToken;

  Data({this.resetToken});

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);
}
