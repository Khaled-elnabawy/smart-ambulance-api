class DirectionsRequestModel {
  final double startLat;
  final double startLng;
  final double endLat;
  final double endLng;

  final String profile;
  final String format;

  DirectionsRequestModel({
    required this.startLat,
    required this.startLng,
    required this.endLat,
    required this.endLng,
    this.profile = "driving-car",
    this.format = "json",
  });

  String get start => "$startLng,$startLat";

  String get end => "$endLng,$endLat";
}
