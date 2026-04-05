import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/core/networking/api_service.dart';
import 'package:mobile/core/services/location/location_service.dart';
import 'package:mobile/features/home/data/models/scheduled_models/scheduled_response_model.dart';
import '../../../../core/networking/api_error_handling.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/services/directions/directions_request_model.dart';
import '../../../../core/services/directions/directions_response_model.dart';
import '../../../../core/services/directions/directions_service.dart';
import '../models/emergency_models/emergency_request_model.dart';
import '../models/emergency_models/emergency_response_model.dart';
import '../models/scheduled_models/scheduled_request_model.dart';

class HomeRepo {
  final LocationService locationService;
  final DirectionsService directionsService;
  final ApiService apiService;

  HomeRepo({
    required this.locationService,
    required this.directionsService,
    required this.apiService,
  });

  Future<LatLng?> getCurrentLocation() async {
    await locationService.checkAndRequestLocationService();

    var hasPermission = await locationService
        .checkAndRequestLocationPermission();

    if (!hasPermission) return null;

    final locationData = await locationService.getCurrentLocationOnce();

    return LatLng(locationData.latitude!, locationData.longitude!);
  }

  Stream<LatLng> getLiveLocation() async* {
    await locationService.checkAndRequestLocationService();
    var hasPermission = await locationService
        .checkAndRequestLocationPermission();

    if (!hasPermission) return;
    await for (final locationData in locationService.getLocationStream()) {
      yield LatLng(locationData.latitude!, locationData.longitude!);
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

  Future<ApiResult<EmergencyResponseModel>> createEmergency(
    EmergencyRequestModel emergencyRequestModel,
  ) async {
    try {
      final response = await apiService.createEmergency(emergencyRequestModel);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ScheduledResponseModel>> createScheduled(
    ScheduledRequestModel scheduledRequestModel,
  ) async {
    try {
      final response = await apiService.createScheduled(scheduledRequestModel);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}

// example on direction request model
/*final request = DirectionsRequestModel(
  origin: LocationWrapper(
    location: Location(
      latLng: LatLngModel(latitude: 30.0444, longitude: 31.2357),
    ),
  ),
  destination: LocationWrapper(
    location: Location(
      latLng: LatLngModel(latitude: 30.0131, longitude: 31.2089),
    ),
  ),
  routingPreference: "TRAFFIC_AWARE",
  units: "METRIC",
  languageCode: "en-US",
);*/
