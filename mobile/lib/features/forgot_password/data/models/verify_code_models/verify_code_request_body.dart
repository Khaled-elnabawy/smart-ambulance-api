import 'package:json_annotation/json_annotation.dart';

part 'verify_code_request_body.g.dart';

@JsonSerializable()
class VerifyCodeRequestBody {
  final String email;
  final String code;

  VerifyCodeRequestBody({required this.email,required this.code});

  Map<String, dynamic> toJson() => _$VerifyCodeRequestBodyToJson(this);
}
