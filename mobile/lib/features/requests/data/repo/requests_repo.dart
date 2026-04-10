import 'package:mobile/core/networking/api_service.dart';

import '../models/requests_request_model.dart';
import '../models/requests_response_model.dart';

class RequestsRepo {
  ApiService apiService;

  RequestsRepo(this.apiService);

  Future<RequestsResponseModel> getRequests({
    required String token,
    required RequestsRequestModel requestsRequestModel,
  }) async {
    final response = await apiService.getRequests('Bearer $token', requestsRequestModel);
    return response;
  }
}
