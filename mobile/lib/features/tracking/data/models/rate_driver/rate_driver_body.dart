import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate_driver_body.g.dart';

@JsonSerializable()
class RateDriverBody {
  final int id;
  final int rating;

  RateDriverBody({
    required this.id,
    required this.rating,
  });

  Map<String, dynamic> toJson() => _$RateDriverBodyToJson(this);
}
