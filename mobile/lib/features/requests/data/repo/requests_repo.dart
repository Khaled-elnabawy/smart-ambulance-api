import 'package:mobile/core/networking/api_service.dart';

import '../../../../core/networking/api_error_handling.dart';
import '../../../../core/networking/api_result.dart';
import '../models/cancel/cancel_request_body.dart';
import '../models/cancel/cancel_response.dart';
import '../models/requests/requests_request_model.dart';
import '../models/requests/requests_response_model.dart';

class RequestsRepo {
  ApiService apiService;

  RequestsRepo(this.apiService);

  Future<ApiResult<RequestsResponseModel>> getRequests({
    required String token,
    required RequestsRequestModel requestsRequestModel,
  }) async {
    try {
      final response = await apiService.getRequests(
        'Bearer $token',
        requestsRequestModel,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<CancelResponse>> cancelRequests({
    required String token,
    required CancelRequestBody cancelRequestBody,
  }) async {
    try {
      final response = await apiService.cancelRequests(
        'Bearer $token',
        cancelRequestBody,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
