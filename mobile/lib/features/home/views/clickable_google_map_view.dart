import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/core/helpers/extensions.dart';
import 'package:mobile/core/widgets/generic_text_button.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/theming/styles.dart';
import '../data/repos/home_repo.dart';

class ClickableGoogleMapView extends StatefulWidget {
  const ClickableGoogleMapView({super.key});

  @override
  State<ClickableGoogleMapView> createState() => _ClickableGoogleMapViewState();
}

class _ClickableGoogleMapViewState extends State<ClickableGoogleMapView> {
  GoogleMapController? _mapController;
  final HomeRepo homeRepo = getIt<HomeRepo>();

  Set<Marker> markers = {};
  late Marker me;
  late LatLng currentLocation;
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    LatLng? pickCurrentLocation = await homeRepo.getCurrentLocation();
    if (pickCurrentLocation != null) {
      selectedLocation = pickCurrentLocation;
      currentLocation = pickCurrentLocation;
      me = Marker(markerId: MarkerId('me'), position: currentLocation);
      markers.add(me);
      _mapController?.animateCamera(CameraUpdate.newLatLng(currentLocation));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(31.04425054350228, 31.363826542206063),
            zoom: 15.5,
          ),
          zoomControlsEnabled: false,
          markers: markers,
          onTap: (LatLng position) {
            setState(() {
              selectedLocation = position;
              markers.removeWhere((marker) => marker.markerId.value == 'me');
              me = Marker(markerId: MarkerId('me'), position: position);
              markers.add(me);
            });
          },
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GenericTextButton(
                buttonText: 'Confirm location',
                textStyle: TextStyles.font16WhiteBold,
                buttonHeight: 45.h,
                buttonWidth: 198.w,
                onPressed: () {
                  if (selectedLocation != null) {
                    log(selectedLocation!.latitude.toString());
                    log(selectedLocation!.longitude.toString());
                    context.pop(selectedLocation);
                  }
                },
              ),
              GenericTextButton(
                buttonText: 'Cancel',
                textStyle: TextStyles.font16RedBold,
                buttonHeight: 45.h,
                buttonWidth: 198.w,
                backgroundColor: Colors.white,
                isHaveBorder: true,
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
