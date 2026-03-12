import 'package:json_annotation/json_annotation.dart';

part 'send_code_response.g.dart';

@JsonSerializable()
class SendCodeResponse {
  String? message;
  Data? data;
  bool? status;
  @JsonKey(name: 'status_code')
  int? code;

  SendCodeResponse({this.message, this.data, this.status, this.code});

  factory SendCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$SendCodeResponseFromJson(json);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'reset_token')
  String? resetToken;

  Data({this.resetToken});

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);
}
