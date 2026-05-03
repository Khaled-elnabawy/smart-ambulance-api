import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final String? message;
  @JsonKey(name: 'data')
  final UserData? userData;
  final bool? status;
  @JsonKey(name: 'status_code')
  final int? code;

  RegisterResponse({this.message, this.userData, this.status, this.code});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  final String? token;
  @JsonKey(name: 'username')
  final UserInfo? userInfo;

  UserData({this.token, this.userInfo});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}

@JsonSerializable()
class UserInfo {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  @JsonKey(name: 'national_id')
  final String? nationalId;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  UserInfo({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.nationalId,
    this.createdAt,
    this.updatedAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}
