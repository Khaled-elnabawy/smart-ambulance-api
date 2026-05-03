import 'package:json_annotation/json_annotation.dart';

part 'scheduled_request_model.g.dart';

@JsonSerializable()
class ScheduledRequestModel {
  @JsonKey(name: "request_type")
  final String requestType; // scheduled
  @JsonKey(name: "pickup_latitude")
  final double pickupLatitude;
  @JsonKey(name: "pickup_longitude")
  final double pickupLongitude;
  @JsonKey(name: "destination_latitude")
  final double destinationLatitude;
  @JsonKey(name: "destination_longitude")
  final double destinationLongitude;
  @JsonKey(name: 'scheduled_time')
  final String scheduledTime;
  @JsonKey(name: 'members_count')
  final int membersCount;

  ScheduledRequestModel({
    required this.requestType,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.scheduledTime,
    required this.membersCount,
  });

  Map<String, dynamic> toJson() => _$ScheduledRequestModelToJson(this);
}
