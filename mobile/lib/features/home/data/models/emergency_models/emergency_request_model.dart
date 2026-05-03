import 'package:json_annotation/json_annotation.dart';

part 'emergency_request_model.g.dart';

@JsonSerializable()
class EmergencyRequestModel {
  @JsonKey(name: "request_type")
  final String requestType; // emergency
  @JsonKey(name: "pickup_latitude")
  final double pickupLatitude;
  @JsonKey(name: "pickup_longitude")
  final double pickupLongitude;

  EmergencyRequestModel({
    required this.requestType,
    required this.pickupLatitude,
    required this.pickupLongitude,
  });

  Map<String,dynamic> toJson() => _$EmergencyRequestModelToJson(this);
}
