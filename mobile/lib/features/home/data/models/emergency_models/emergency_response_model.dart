import 'package:json_annotation/json_annotation.dart';

part 'emergency_response_model.g.dart';

@JsonSerializable()
class EmergencyResponseModel {
  final String? message;
  final bool? status;
  @JsonKey(name: 'status_code')
  final int? code;
  final EmergencyData? data;

  EmergencyResponseModel({this.message, this.status, this.code, this.data});

  factory EmergencyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EmergencyResponseModelFromJson(json);
}

@JsonSerializable()
class EmergencyData {
  final int? id;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'ambulance_id')
  final int? ambulanceId;
  @JsonKey(name: 'driver_id')
  final int? driverId;
  @JsonKey(name: 'request_type')
  final String? requestType;
  final String? status;
  @JsonKey(name: 'pickup_latitude')
  final String? pickup_Latitude;
  @JsonKey(name: 'pickup_longitude')
  final String? pickupLongitude;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  EmergencyData({
    this.id,
    this.userId,
    this.ambulanceId,
    this.driverId,
    this.requestType,
    this.status,
    this.pickup_Latitude,
    this.pickupLongitude,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory EmergencyData.fromJson(Map<String, dynamic> json) =>
      _$EmergencyDataFromJson(json);
}
