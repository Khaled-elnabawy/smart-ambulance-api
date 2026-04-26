import 'package:mobile/core/networking/api_service.dart';
import '../../../../core/networking/api_error_handling.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/services/directions/directions_request_model.dart';
import '../../../../core/services/directions/directions_response_model.dart';
import '../../../../core/services/directions/directions_service.dart';
import '../models/action_request/action_request_body.dart';
import '../models/action_request/action_request_response.dart';
import '../models/rate_driver/rate_driver_body.dart';
import '../models/rate_driver/rate_driver_response.dart';
import '../models/track_request/track_request_response.dart';
import '../models/update_location/update_location_body.dart';
import '../models/update_location/update_location_response.dart';

class TrackingRepo {
  final ApiService apiService;
  final DirectionsService directionsService;

  TrackingRepo(this.apiService, this.directionsService);

  Future<ApiResult<TrackRequestResponse>> trackRequest(
    String token,
    int id,
  ) async {
    try {
      final response = await apiService.trackRequest('Bearer $token', id);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<UpdateLocationResponse>> updateLocation(
    String token,
    double latitude,
    double longitude,
  ) async {
    try {
      final response = await apiService.updateLocation(
        'Bearer $token',
        UpdateLocationBody(latitude: latitude, longitude: longitude),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<ActionRequestResponse>> arrivedRequest(
    String token,
    int id,
  ) async {
    try {
      final response = await apiService.arrivedRequest(
        'Bearer $token',
        ActionRequestBody(id: id),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<ActionRequestResponse>> completeRequest(
    String token,
    int id,
  ) async {
    try {
      final response = await apiService.completeRequest(
        'Bearer $token',
        ActionRequestBody(id: id),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<RateDriverResponse>> rateDriver(
    String token,
    int id,
    int rating,
  ) async {
    try {
      final response = await apiService.rateDriver(
        'Bearer $token',
        RateDriverBody(id: id, rating: rating),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DirectionsResponseModel>> getRoute(
    DirectionsRequestModel directionsRequestModel,
  ) async {
    try {
      final response = await directionsService.getRoute(directionsRequestModel);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
