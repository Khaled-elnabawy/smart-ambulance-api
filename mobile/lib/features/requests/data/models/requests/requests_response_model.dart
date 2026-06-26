import 'package:json_annotation/json_annotation.dart';

part 'requests_response_model.g.dart';

@JsonSerializable()
class RequestsResponseModel {
  final bool? status;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  @JsonKey(name: 'data')
  final List<Request>? requests;

  RequestsResponseModel({this.status, this.statusCode, this.requests});

  factory RequestsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RequestsResponseModelFromJson(json);
}

@JsonSerializable()
class Request {
  final int? id;
  @JsonKey(name: 'request_type')
  final String? requestType;
  final String? status;
  @JsonKey(name: 'pickup_latitude')
  final String? pickupLatitude;
  @JsonKey(name: 'pickup_longitude')
  final String? pickupLongitude;
  @JsonKey(name: 'destination_latitude')
  final String? destinationLatitude;
  @JsonKey(name: 'destination_longitude')
  final String? destinationLongitude;
  @JsonKey(name: 'scheduled_time')
  final String? scheduledTime;
  @JsonKey(name: 'members_count')
  final int? membersCount;
  @JsonKey(name: 'driver_id')
  final int? driverId;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  final int? rating;

  Request({
    this.id,
    this.requestType,
    this.status,
    this.pickupLatitude,
    this.pickupLongitude,
    this.destinationLatitude,
    this.destinationLongitude,
    this.scheduledTime,
    this.membersCount,
    this.driverId,
    this.userId,
    this.createdAt,
    this.rating,
  });

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);
}
