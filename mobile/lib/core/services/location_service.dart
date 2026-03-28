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
    if (permission == PermissionStatus.denied) {
      return false;
    }
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      return permission == PermissionStatus.granted ||
          permission == PermissionStatus.grantedLimited;
    }
    return true;
  }

  void getLocationData(void Function(LocationData)? onData) {
    location.onLocationChanged.listen(onData);
  }
}

/*location.changeSettings(
          distanceFilter: 5
      );
      LatLng myLocation = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
      Marker myLocationMarker = Marker(
        markerId: MarkerId('myLocation'),
        icon: await BitmapDescriptor.asset(
          ImageConfiguration.empty,
          'assets/images/truck_kun.png',
        ),
        position: myLocation,
      );
      markers.add(myLocationMarker);
      setState(() {});
      _mapController?.animateCamera(CameraUpdate.newLatLng(myLocation));*/
