// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequestBody _$ResetPasswordRequestBodyFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequestBody(
  email: json['email'] as String,
  resetToken: json['token'] as String,
  password: json['password'] as String,
  confirmPassword: json['confirm_password'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestBodyToJson(
  ResetPasswordRequestBody instance,
) => <String, dynamic>{
  'email': instance.email,
  'token': instance.resetToken,
  'password': instance.password,
  'confirm_password': instance.confirmPassword,
};
