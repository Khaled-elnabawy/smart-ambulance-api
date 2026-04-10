import 'package:mobile/core/networking/api_service.dart';

import '../../../../core/networking/api_error_handling.dart';
import '../../../../core/networking/api_result.dart';
import '../models/requests_request_model.dart';
import '../models/requests_response_model.dart';

class RequestsRepo {
  ApiService apiService;

  RequestsRepo(this.apiService);

  Future<ApiResult<RequestsResponseModel>> getRequests({
    required String token,
    required RequestsRequestModel requestsRequestModel,
  }) async {
    try{
      final response = await apiService.getRequests('Bearer $token', requestsRequestModel);
      return ApiResult.success(response);
    }catch(error){
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
