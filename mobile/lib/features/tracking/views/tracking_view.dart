import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/core/helpers/extensions.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/services/directions/directions_request_model.dart';
import '../../data/models/track_request/track_request_response.dart';
import '../../data/repos/tracking_repo.dart';
import '../../logic/tracking_cubit/tracking_cubit.dart';
import 'widgets/driver_controls_overlay.dart';
import 'widgets/tracking_header_overlay.dart';
import 'widgets/tracking_listeners.dart';

class TrackingView extends StatefulWidget {
  final int requestId;
  final String token;
  final bool isDriver;

  const TrackingView({
    super.key,
    required this.requestId,
    required this.token,
    required this.isDriver,
  });

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  GoogleMapController? _mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  final CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(31.04425054350228, 31.363826542206063), // Fallback location
    zoom: 15.5,
  );

  bool _isRouteDrawn = false;
  TrackRequestData? _requestData;

  @override
  void initState() {
    super.initState();
    // Start tracking polling
    context.read<TrackingCubit>().startPolling(
          token: widget.token,
          id: widget.requestId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TrackingListeners(
        requestId: widget.requestId,
        token: widget.token,
        isDriver: widget.isDriver,
        onTrackingDataUpdated: (data) async {
          setState(() {
            _requestData = data;
          });
          await _updateMapWithTrackingData(data);
        },
        child: Stack(
          children: [
            _buildMap(),
            TrackingHeaderOverlay(isDriver: widget.isDriver),
            DriverControlsOverlay(
              isDriver: widget.isDriver,
              requestData: _requestData,
              token: widget.token,
              requestId: widget.requestId,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      markers: markers,
      polylines: polylines,
      initialCameraPosition: initialCameraPosition,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
    );
  }

  Future<void> _updateMapWithTrackingData(TrackRequestData data) async {
    if (data.pickupLatitude == null || data.pickupLongitude == null) return;
    if (data.driver == null || data.driver!.lastLatitude == null || data.driver!.lastLongitude == null) return;

    LatLng pickup = LatLng(
      double.parse(data.pickupLatitude!),
      double.parse(data.pickupLongitude!),
    );

    LatLng driverLoc = LatLng(
      double.parse(data.driver!.lastLatitude!),
      double.parse(data.driver!.lastLongitude!),
    );

    Set<Marker> newMarkers = {};
    newMarkers.add(Marker(
      markerId: const MarkerId('pickup'),
      position: pickup,
      icon: await BitmapDescriptor.asset(
        const ImageConfiguration(),
        'assets/images/help_point.png',
      ),
    ));

    newMarkers.add(Marker(
      markerId: const MarkerId('driver'),
      position: driverLoc,
      icon: await BitmapDescriptor.asset(
        const ImageConfiguration(),
        'assets/images/truck_kun.png',
      ),
    ));

    setState(() {
      markers = newMarkers;
    });

    if (!_isRouteDrawn) {
      _isRouteDrawn = true;
      _drawRoute(driverLoc, pickup);
    } else {
      // Just update camera
      _mapController?.animateCamera(CameraUpdate.newLatLng(driverLoc));
    }
  }

  Future<void> _drawRoute(LatLng start, LatLng end) async {
    final trackingRepo = getIt<TrackingRepo>();
    
    // Fallback: Just draw a straight line if route fails
    void drawStraightLine() {
      setState(() {
        polylines.add(Polyline(
          polylineId: const PolylineId('route'),
          color: ColorsManager.red,
          width: 4,
          points: [start, end],
        ));
      });
      _fitMapToPoints(start, end);
    }

    final req = DirectionsRequestModel(
      start: start,
      end: end,
      profile: "driving-car",
    );

    final res = await trackingRepo.getRoute(req);
    res.when(
      success: (data) {
        if (data.features != null && data.features!.isNotEmpty) {
          final coordinates = data.features!.first.geometry?.coordinates;
          if (coordinates != null) {
            List<LatLng> points = coordinates.map((coord) {
              // OpenRouteService returns [longitude, latitude]
              return LatLng(coord[1], coord[0]);
            }).toList();

            setState(() {
              polylines.add(Polyline(
                polylineId: const PolylineId('route'),
                color: ColorsManager.red,
                width: 4,
                points: points,
              ));
            });
            _fitMapToPoints(start, end);
          } else {
            drawStraightLine();
          }
        } else {
          drawStraightLine();
        }
      },
      failure: (err) {
        drawStraightLine();
      },
    );
  }

  void _fitMapToPoints(LatLng start, LatLng end) {
    if (_mapController == null) return;

    LatLngBounds bounds;
    if (start.latitude > end.latitude && start.longitude > end.longitude) {
      bounds = LatLngBounds(southwest: end, northeast: start);
    } else if (start.longitude > end.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(start.latitude, end.longitude),
          northeast: LatLng(end.latitude, start.longitude));
    } else if (start.latitude > end.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(end.latitude, start.longitude),
          northeast: LatLng(start.latitude, end.longitude));
    } else {
      bounds = LatLngBounds(southwest: start, northeast: end);
    }

    _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60));
  }
}
