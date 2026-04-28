import 'package:json_annotation/json_annotation.dart';

part 'confirm_response_model.g.dart';

@JsonSerializable()
class ConfirmResponseModel {
  final bool? status;
  final String? message;

  @JsonKey(name: 'status_code')
  final int? statusCode;

  ConfirmResponseModel({this.status, this.message, this.statusCode});

  factory ConfirmResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmResponseModelFromJson(json);

}
