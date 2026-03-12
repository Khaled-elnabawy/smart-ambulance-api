import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request_body.g.dart';

@JsonSerializable()
class ResetPasswordRequestBody {
  final String email;
  @JsonKey(name: 'token')
  final String resetToken;
  final String password;
  @JsonKey(name: 'confirm_password')
  final String confirmPassword;

  ResetPasswordRequestBody({
    required this.email,
    required this.resetToken,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordRequestBodyToJson(this);
}
