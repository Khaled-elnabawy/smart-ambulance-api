// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_driver_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateDriverResponse _$RateDriverResponseFromJson(Map<String, dynamic> json) =>
    RateDriverResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : RateDriverData.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: (json['status_code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RateDriverResponseToJson(RateDriverResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'status_code': instance.statusCode,
    };

RateDriverData _$RateDriverDataFromJson(Map<String, dynamic> json) =>
    RateDriverData(
      rating: (json['rating'] as num?)?.toInt(),
      driverAverageRating: (json['driver_average_rating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RateDriverDataToJson(RateDriverData instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'driver_average_rating': instance.driverAverageRating,
    };
