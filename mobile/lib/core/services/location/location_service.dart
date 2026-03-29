import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<bool> checkAndRequestLocationService() async {
    bool isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkAndRequestLocationPermission() async {
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.deniedForever) {
      return false;
    }
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      return permission == PermissionStatus.granted ||
          permission == PermissionStatus.grantedLimited;
    }
    return true;
  }

  Future<LocationData> getCurrentLocationOnce() async {
    return await location.getLocation();
  }

  Stream<LocationData> getLocationStream() {
    location.changeSettings(distanceFilter: 5);
    return location.onLocationChanged;
  }
}
