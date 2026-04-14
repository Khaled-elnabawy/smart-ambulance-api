import 'package:mobile/core/networking/api_result.dart';
import 'package:mobile/core/networking/api_service.dart';
import 'package:mobile/features/profile/data/models/edit_profile/edit_profile_response_model.dart';
import 'package:mobile/features/profile/data/models/logout/logout_response_model.dart';
import '../../../../core/networking/api_error_handling.dart';
import '../models/edit_profile/edit_profile_request_model.dart';

class ProfileRepo {
  final ApiService _apiService;

  ProfileRepo(this._apiService);

  Future<ApiResult<LogoutResponseModel>> logout(String token) async {
    try {
      final response = await _apiService.logout('Bearer $token');
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<EditProfileResponseModel>> editProfile(
    String token,
    EditProfileRequestModel editProfileRequestModel,
  ) async {
    try {
      final response = await _apiService.editProfile(
        'Bearer $token',
        editProfileRequestModel,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
