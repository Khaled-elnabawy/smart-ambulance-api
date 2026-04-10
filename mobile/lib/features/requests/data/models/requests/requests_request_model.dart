import 'package:json_annotation/json_annotation.dart';

part 'requests_request_model.g.dart';

@JsonSerializable()
class RequestsRequestModel {
  final String? type;

  RequestsRequestModel({required this.type});

  Map<String, dynamic> toJson() => _$RequestsRequestModelToJson(this);
}
