import 'dart:io';
import 'directions_api_service.dart';
import 'directions_request_model.dart';
import 'directions_response_model.dart';

class DirectionsService {
  final DirectionsApiService directionsApiService;

  DirectionsService(this.directionsApiService);

  Future<DirectionsResponseModel> getRoute(
    DirectionsRequestModel directionsRequestModel,
  ) async {
    final DirectionsResponseModel routes = await directionsApiService.getRoute(
      directionsRequestModel,
      Platform.isAndroid
          ? "AIzaSyD_pHJ0cIqd3ZRepnbeoeP7VFZqKfIgCaE"
          : "AIzaSyA20j9I9voKjtUN4YdUPeP0Mi5cCRiObMU",
      "routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline",
      "application/json",
    );
    return routes;
  }
}


