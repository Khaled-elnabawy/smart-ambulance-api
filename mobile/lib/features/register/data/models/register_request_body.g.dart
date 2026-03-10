// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestBody _$RegisterRequestBodyFromJson(Map<String, dynamic> json) =>
    RegisterRequestBody(
      name: json['name'] as String,
      phone: json['phone'] as String,
      nationalId: json['national_id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['confirm_password'] as String,
    );

Map<String, dynamic> _$RegisterRequestBodyToJson(
  RegisterRequestBody instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'national_id': instance.nationalId,
  'email': instance.email,
  'password': instance.password,
  'confirm_password': instance.passwordConfirmation,
};
