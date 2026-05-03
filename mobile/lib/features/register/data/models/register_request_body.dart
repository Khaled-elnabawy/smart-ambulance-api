import 'package:json_annotation/json_annotation.dart';

part 'register_request_body.g.dart';

@JsonSerializable()
class RegisterRequestBody {
  final String name;
  final String phone;
  @JsonKey(name: 'national_id')
  final String nationalId;
  final String email;
  final String password;
  @JsonKey(name: 'confirm_password')
  final String passwordConfirmation;

  RegisterRequestBody({
    required this.name,
    required this.phone,
    required this.nationalId,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);

}
