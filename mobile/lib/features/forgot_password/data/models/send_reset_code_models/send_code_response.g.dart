// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendCodeResponse _$SendCodeResponseFromJson(Map<String, dynamic> json) =>
    SendCodeResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SendCodeResponseToJson(SendCodeResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'status': instance.status,
      'code': instance.code,
    };

Data _$DataFromJson(Map<String, dynamic> json) =>
    Data(resetToken: json['reset_token'] as String?);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'reset_token': instance.resetToken,
};
