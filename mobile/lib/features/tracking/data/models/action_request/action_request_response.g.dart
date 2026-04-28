// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionRequestResponse _$ActionRequestResponseFromJson(
  Map<String, dynamic> json,
) => ActionRequestResponse(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  statusCode: (json['status_code'] as num?)?.toInt(),
);

Map<String, dynamic> _$ActionRequestResponseToJson(
  ActionRequestResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'status_code': instance.statusCode,
};
