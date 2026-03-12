import 'package:json_annotation/json_annotation.dart';

part 'send_reset_code_response.g.dart';

@JsonSerializable()
class SendResetCodeResponse {
  String? message;
  Data? data;
  bool? status;
  int? code;

  SendResetCodeResponse({this.message, this.data, this.status, this.code});

  factory SendResetCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$SendResetCodeResponseFromJson(json);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'reset_token')
  String? resetToken;

  Data({this.resetToken});

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);
}
