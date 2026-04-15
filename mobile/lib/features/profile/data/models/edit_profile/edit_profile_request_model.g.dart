// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileRequestModel _$EditProfileRequestModelFromJson(
  Map<String, dynamic> json,
) => EditProfileRequestModel(
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$EditProfileRequestModelToJson(
  EditProfileRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'email': instance.email,
};
