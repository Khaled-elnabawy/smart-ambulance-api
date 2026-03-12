import 'package:mobile/features/forget_password/data/models/send_reset_code_models/send_reset_code_request_body.dart';

import '../../../../core/networking/api_error_handling.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/send_reset_code_models/send_reset_code_response.dart';


class ForgetPasswordRepo {
  final ApiService apiService;

  ForgetPasswordRepo(this.apiService);

  Future<ApiResult<SendResetCodeResponse>> sendCode(
      SendResetCodeRequestBody sendResetCodeRequestBody,
      ) async {
    try {
      final response = await apiService.sendCode(sendResetCodeRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
