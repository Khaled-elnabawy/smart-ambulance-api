import 'package:json_annotation/json_annotation.dart';

part 'send_code_request_body.g.dart';

@JsonSerializable()
class SendCodeRequestBody {
  final String email;

  SendCodeRequestBody({required this.email});

  Map<String, dynamic> toJson() => _$SendCodeRequestBodyToJson(this);
}
