import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_location_body.g.dart';

@JsonSerializable()
class UpdateLocationBody {
  final double latitude;
  final double longitude;

  UpdateLocationBody({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => _$UpdateLocationBodyToJson(this);
}
