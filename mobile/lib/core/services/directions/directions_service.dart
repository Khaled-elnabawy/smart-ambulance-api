import 'dart:io';
import 'package:mobile/core/config/env.dart';

import 'directions_api_service.dart';
import 'directions_request_model.dart';
import 'directions_response_model.dart';

class DirectionsService {
  final DirectionsApiService directionsApiService;

  DirectionsService(this.directionsApiService);

  Future<DirectionsResponseModel> getRoute(DirectionsRequestModel request) {
    return directionsApiService.getRoute(
      request.profile,
      Env.routeApiKey,
      request.start,
      request.end,
    );
  }
}
