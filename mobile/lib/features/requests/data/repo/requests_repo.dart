import 'package:mobile/core/networking/api_service.dart';
import 'package:mobile/features/requests/data/models/confirm/confirm_response_model.dart';
import '../../../../core/networking/api_error_handling.dart';
import '../../../../core/networking/api_result.dart';
import '../models/cancel/cancel_request_body.dart';
import '../models/cancel/cancel_response.dart';
import '../models/confirm/confirm_request_body.dart';
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
      final response = await apiService.cancelRequest(
        'Bearer $token',
        cancelRequestBody,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ConfirmResponseModel>> confirmRequest({
    required String token,
    required ConfirmRequestBody confirmRequestBody,
  }) async {
    try {
      final response = await apiService.acceptRequest(
        'Bearer $token',
        confirmRequestBody,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<CancelResponse>> rejectRequest({
    required String token,
    required CancelRequestBody cancelRequestBody,
  }) async {
    try {
      final response = await apiService.rejectRequest(
        'Bearer $token',
        cancelRequestBody,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
