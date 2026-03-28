import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/core/networking/api_service.dart';
import 'package:mobile/core/services/location_service.dart';

class HomeRepo {
  final LocationService locationService;
  final ApiService apiService;

  HomeRepo({required this.locationService, required this.apiService});

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
}


