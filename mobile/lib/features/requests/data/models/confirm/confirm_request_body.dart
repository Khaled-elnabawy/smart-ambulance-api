import 'package:json_annotation/json_annotation.dart';

part 'confirm_request_body.g.dart';

@JsonSerializable()
class ConfirmRequestBody {
  final int? id;

  ConfirmRequestBody({this.id});

  Map<String, dynamic> toJson() => _$ConfirmRequestBodyToJson(this);
}
