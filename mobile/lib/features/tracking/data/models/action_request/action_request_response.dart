import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_request_response.g.dart';

@JsonSerializable()
class ActionRequestResponse {
  final bool? status;
  final String? message;
  @JsonKey(name: 'status_code')
  final int? statusCode;

  ActionRequestResponse({this.status, this.message, this.statusCode});

  factory ActionRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$ActionRequestResponseFromJson(json);
}
