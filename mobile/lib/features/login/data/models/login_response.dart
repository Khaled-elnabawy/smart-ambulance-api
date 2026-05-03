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
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? token;
  @JsonKey(name: 'user_type')
  final String? userType;
  final double? rating;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.token,
    this.userType,
    this.rating,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
