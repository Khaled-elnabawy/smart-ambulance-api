import 'package:json_annotation/json_annotation.dart';

part 'logout_response_model.g.dart';

@JsonSerializable()
class LogoutResponseModel {
  final String? message;
  @JsonKey(name: 'status_code')
  final int? statusCode;

  LogoutResponseModel({required this.message, required this.statusCode});

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseModelFromJson(json);
}
