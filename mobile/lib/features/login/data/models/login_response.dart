import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? message;
  @JsonKey(name: 'data')
  UserData? userData;
  bool? status;
  @JsonKey(name: 'status_code')
  int? code;

  LoginResponse({this.message, this.userData, this.status, this.code});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  String? token;
  @JsonKey(name: 'user_type')
  String? userType;
  @JsonKey(name: 'user')
  UserInfo? userInfo;

  UserData({this.token, this.userInfo});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}

@JsonSerializable()
class UserInfo {
  int? id;
  String? name;
  String? phone;
  String? email;
  @JsonKey(name: 'national_id')
  String? nationalId;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  UserInfo({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}
