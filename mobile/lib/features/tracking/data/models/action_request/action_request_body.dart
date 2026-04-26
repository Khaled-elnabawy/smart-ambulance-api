import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_request_body.g.dart';

@JsonSerializable()
class ActionRequestBody {
  final int id;

  ActionRequestBody({required this.id});

  Map<String, dynamic> toJson() => _$ActionRequestBodyToJson(this);
}
