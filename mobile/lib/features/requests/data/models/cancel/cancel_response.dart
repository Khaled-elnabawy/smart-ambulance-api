import 'package:json_annotation/json_annotation.dart';

part 'cancel_response.g.dart';

@JsonSerializable()
class CancelResponse {
  final bool? status;
  final String? message;

  @JsonKey(name: 'status_code')
  final int? statusCode;

  CancelResponse({this.status, this.message, this.statusCode});

  factory CancelResponse.fromJson(Map<String, dynamic> json) =>
      _$CancelResponseFromJson(json);
}
