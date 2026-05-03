import 'package:json_annotation/json_annotation.dart';

part 'cancel_request_body.g.dart';

@JsonSerializable()
class CancelRequestBody {
  final int? id;

  CancelRequestBody({this.id});

  Map<String, dynamic> toJson() => _$CancelRequestBodyToJson(this);
}
