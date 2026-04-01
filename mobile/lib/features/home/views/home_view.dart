import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/core/helpers/extensions.dart';
import 'package:mobile/core/services/directions/directions_request_model.dart';
import 'package:mobile/core/theming/colors.dart';
import 'package:mobile/core/theming/styles.dart';
import 'package:mobile/features/home/data/repos/home_repo.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/routing/routes.dart';
import '../../../core/services/location/location_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeRepo homeRepo = HomeRepo(
    locationService: LocationService(),
    directionsService: getIt(),
    apiService: getIt(),
  );
  late final CameraPosition initialCameraPosition;
  GoogleMapController? _mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    initialCameraPosition = CameraPosition(
      target: LatLng(31.04425054350228, 31.363826542206063),
      zoom: 15.5,
    );
    //initMarkers();
    //createRoute();
  }

  void getCurrentLocation() async {
    LatLng? currentLocation = await homeRepo.getCurrentLocation();
    if (currentLocation != null) {
      _mapController?.animateCamera(CameraUpdate.newLatLng(currentLocation));
    }
  }

  void getLiveLocation() {
    Stream<LatLng> liveLocation = homeRepo.getLiveLocation();
    liveLocation.listen((position) {
      _mapController?.animateCamera(CameraUpdate.newLatLng(position));
    });
  }

  void createRoute() async {
    LatLng? currentLocation = await homeRepo.getCurrentLocation();

    final response = await homeRepo.getRoute(
      DirectionsRequestModel(
        startLat: currentLocation!.latitude,
        startLng: currentLocation.longitude,
        endLat: 31.03290014073697,
        endLng: 31.37388111583407,
      ),
    );
    response.when(
      success: (directionsResponseModel) {
        List<List<double>> points =
            directionsResponseModel.features[0].geometry.coordinates;
        polylines.add(
          Polyline(
            polylineId: PolylineId('route'),
            points: points.map((point) => LatLng(point[1], point[0])).toList(),
            color: Colors.blue,
            width: 5,
          ),
        );
        setState(() {});
      },
      failure: (error) {
        log(error.apiErrorModel.message.toString());
      },
    );
  }

  /*Marker myLocationMarker = Marker(
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

  void initMarkers() async {
    Marker help = Marker(
      markerId: MarkerId('1'),
      icon: await BitmapDescriptor.asset(
        ImageConfiguration.empty,
        'assets/images/help_point.png',
      ),
      position: LatLng(31.046162023854304, 31.365445177935857),
    );
    Marker ambulancer = Marker(
      markerId: MarkerId('2'),
      icon: await BitmapDescriptor.asset(
        ImageConfiguration.empty,
        'assets/images/truck_kun.png',
      ),
      position: LatLng(31.04421054551063, 31.36439857355452),
    );
    markers.add(help);
    markers.add(ambulancer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: markers,
            polylines: polylines,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            zoomControlsEnabled: false,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 148.h,
              decoration: BoxDecoration(
                color: ColorsManager.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60.h),
                    Text('Hello Amr', style: TextStyles.font24WhiteBold),
                    SizedBox(height: 4.h),
                    Text('Are you okay?', style: TextStyles.font20WhiteBold),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 302.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'What do you want to do?',
                      style: TextStyles.font24BlackBold,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 192.w,
                            height: 192.h,
                            decoration: BoxDecoration(
                              color: ColorsManager.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.r),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/sos_ emergency.png',
                                  width: 120.w,
                                  height: 120.h,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 4.h),
                                Text('SOS', style: TextStyles.font32WhiteBold),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(Routes.scheduledFormView);
                          },
                          child: Container(
                            width: 192.w,
                            height: 192.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.r),
                              ),
                              border: Border.all(
                                color: ColorsManager.red,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/calendar.png',
                                  width: 120.w,
                                  height: 120.h,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Scheduled',
                                  style: TextStyles.font32RedBold,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// for resize icon image
/*Future<Uint8List> getImageFromRawData(String image, double width) async {
    var imageData = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
        imageData.buffer.asUint8List(),
        targetWidth: width.round());

    var imageFrameInfo = await imageCodec.getNextFrame();

    var imageBytData =
        await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);

    return imageBytData!.buffer.asUint8List();
  }*/
