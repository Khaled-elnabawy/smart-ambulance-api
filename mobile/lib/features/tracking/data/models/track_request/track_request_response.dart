import 'package:freezed_annotation/freezed_annotation.dart';

part 'track_request_response.g.dart';

@JsonSerializable()
class TrackRequestResponse {
  final bool? status;
  final TrackRequestData? data;
  @JsonKey(name: 'status_code')
  final int? statusCode;

  TrackRequestResponse({this.status, this.data, this.statusCode});

  factory TrackRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackRequestResponseFromJson(json);
}

@JsonSerializable()
class TrackRequestData {
  @JsonKey(name: 'request_id')
  final int? requestId;
  final String? status;
  @JsonKey(name: 'request_type')
  final String? requestType;
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
  final TrackRequestDriver? driver;

  TrackRequestData({
    this.requestId,
    this.status,
    this.requestType,
    this.pickupLatitude,
    this.pickupLongitude,
    this.destinationLatitude,
    this.destinationLongitude,
    this.scheduledTime,
    this.membersCount,
    this.driver,
  });

  factory TrackRequestData.fromJson(Map<String, dynamic> json) =>
      _$TrackRequestDataFromJson(json);
}

@JsonSerializable()
class TrackRequestDriver {
  final int? id;
  final String? name;
  final String? phone;
  @JsonKey(name: 'last_latitude')
  final String? lastLatitude;
  @JsonKey(name: 'last_longitude')
  final String? lastLongitude;

  TrackRequestDriver({
    this.id,
    this.name,
    this.phone,
    this.lastLatitude,
    this.lastLongitude,
  });

  factory TrackRequestDriver.fromJson(Map<String, dynamic> json) =>
      _$TrackRequestDriverFromJson(json);
}
