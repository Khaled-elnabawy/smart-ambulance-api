import '../../../../core/networking/api_error_handling.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/reset_password_models/reset_password_request_body.dart';
import '../models/reset_password_models/reset_password_response.dart';
import '../models/send_code_models/send_code_request_body.dart';
import '../models/send_code_models/send_code_response.dart';
import '../models/verify_code_models/verify_code_request_body.dart';
import '../models/verify_code_models/verify_code_response.dart';


class ForgotPasswordRepo {
  final ApiService apiService;

  ForgotPasswordRepo(this.apiService);

  Future<ApiResult<SendCodeResponse>> sendCode(
      SendCodeRequestBody sendCodeRequestBody,) async {
    try {
      final response = await apiService.sendCode(sendCodeRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<VerifyCodeResponse>> verifyCode(
      VerifyCodeRequestBody verifyCodeRequestBody,) async {
    try {
      final response = await apiService.verifyCode(verifyCodeRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
  Future<ApiResult<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequestBody resetPasswordRequestBody,) async {
    try {
      final response = await apiService.resetPassword(
          resetPasswordRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
