import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_response_model.g.dart';

@JsonSerializable()
class EditProfileResponseModel {
  final bool? status;
  final String? message;
  final Data? data;

  EditProfileResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileResponseModelFromJson(json);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'user')
  final UserData? userData;

  Data({required this.userData});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@JsonSerializable()
class UserData {
  final int? id;
  final String? name;
  final String? phone;
  @JsonKey(name: 'national_id')
  final String? nationalId;
  final String? email;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  UserData({
    required this.id,
    required this.name,
    required this.phone,
    required this.nationalId,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
