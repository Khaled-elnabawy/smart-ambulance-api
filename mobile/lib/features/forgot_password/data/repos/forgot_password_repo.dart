import '../../../../core/networking/api_error_handling.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/send_reset_code_models/send_code_request_body.dart';
import '../models/send_reset_code_models/send_code_response.dart';


class ForgotPasswordRepo {
  final ApiService apiService;

  ForgotPasswordRepo(this.apiService);

  Future<ApiResult<SendCodeResponse>> sendCode(
      SendCodeRequestBody sendCodeRequestBody,
      ) async {
    try {
      final response = await apiService.sendCode(sendCodeRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
