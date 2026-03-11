import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  String? message;
  @JsonKey(name: 'data')
  UserData? userData;
  bool? status;
  int? code;

  RegisterResponse({this.message, this.userData, this.status, this.code});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  String? token;
  @JsonKey(name: 'username')
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

  UserInfo({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}
