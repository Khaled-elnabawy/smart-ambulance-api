import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request_model.g.dart';

@JsonSerializable()
class EditProfileRequestModel {
  final String? name;
  final String? phone;
  final String? email;

  EditProfileRequestModel({
    required this.name,
    required this.phone,
    required this.email,
  });
  Map<String,dynamic> toJson() => _$EditProfileRequestModelToJson(this);
}
