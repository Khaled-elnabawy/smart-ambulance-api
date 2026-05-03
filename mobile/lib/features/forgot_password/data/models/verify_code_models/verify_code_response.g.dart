// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyCodeResponse _$VerifyCodeResponseFromJson(Map<String, dynamic> json) =>
    VerifyCodeResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool?,
      code: (json['status_code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VerifyCodeResponseToJson(VerifyCodeResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'status': instance.status,
      'status_code': instance.code,
    };

Data _$DataFromJson(Map<String, dynamic> json) =>
    Data(resetToken: json['reset_token'] as String?);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'reset_token': instance.resetToken,
};
