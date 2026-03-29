import 'package:dio/dio.dart';
import 'package:mobile/core/services/directions/directions_response_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'directions_request_model.dart';

part 'directions_api_service.g.dart';

@RestApi(baseUrl: "https://routes.googleapis.com/")
abstract class DirectionsApiService {
  factory DirectionsApiService(Dio dio, {String baseUrl}) =
      _DirectionsApiService;

  @POST("directions/v2:computeRoutes")
  Future<DirectionsResponseModel> getRoute(
    @Body() DirectionsRequestModel body,
    @Header("X-Goog-Api-Key") String apiKey,
    @Header("X-Goog-FieldMask") String fieldMask,
    @Header("Content-Type") String contentType,
  );
}
