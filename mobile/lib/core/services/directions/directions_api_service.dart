import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'directions_response_model.dart';

part 'directions_api_service.g.dart';

@RestApi(baseUrl: "https://api.openrouteservice.org/")
abstract class DirectionsApiService {
  factory DirectionsApiService(Dio dio, {String baseUrl}) =
      _DirectionsApiService;

  @GET("v2/directions/{profile}")
  @Headers({
    "Accept":
        "application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8",
  })
  Future<DirectionsResponseModel> getRoute(
    @Path("profile") String profile,

    @Query("api_key") String apiKey,
    @Query("start") String start,
    @Query("end") String end,
  );
}
