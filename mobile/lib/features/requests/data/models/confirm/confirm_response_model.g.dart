// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmResponseModel _$ConfirmResponseModelFromJson(
  Map<String, dynamic> json,
) => ConfirmResponseModel(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  statusCode: (json['status_code'] as num?)?.toInt(),
);

Map<String, dynamic> _$ConfirmResponseModelToJson(
  ConfirmResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'status_code': instance.statusCode,
};
