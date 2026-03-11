// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      message: json['message'] as String?,
      userData: json['data'] == null
          ? null
          : UserData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.userData,
      'status': instance.status,
      'code': instance.code,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
  token: json['token'] as String?,
  userInfo: json['username'] == null
      ? null
      : UserInfo.fromJson(json['username'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  'token': instance.token,
  'username': instance.userInfo,
};

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
)..nationalId = json['national_id'] as String?;

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone': instance.phone,
  'email': instance.email,
  'national_id': instance.nationalId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
