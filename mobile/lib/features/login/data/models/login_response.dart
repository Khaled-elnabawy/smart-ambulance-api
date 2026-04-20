import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String? message;
  final bool? status;
  @JsonKey(name: 'status_code')
  final int? code;
  @JsonKey(name: 'data')
  final UserData? userData;

  LoginResponse({this.message, this.status, this.code, this.userData});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  final String? token;
  @JsonKey(name: 'user_type')
  final String? userType;
  final double? rating;
  @JsonKey(name: 'user')
  final UserInfo? userInfo;

  UserData({this.token, this.userInfo, this.userType, this.rating});

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
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  UserInfo({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.nationalId,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}
