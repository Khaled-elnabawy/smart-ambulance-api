import 'package:json_annotation/json_annotation.dart';

part 'send_reset_code_request_body.g.dart';

@JsonSerializable()
class SendResetCodeRequestBody {
  final String email;

  SendResetCodeRequestBody({required this.email});

  Map<String, dynamic> toJson() => _$SendResetCodeRequestBodyToJson(this);
}
