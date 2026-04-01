import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/features/home/views/widgets/home_bottom_section.dart';
import 'package:mobile/features/home/views/widgets/home_top_section.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isMapExpanded = false;
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
  }



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
            zoomControlsEnabled: false,
            onTap: (LatLng position) {
              setState(() {
                isMapExpanded = !isMapExpanded;
              });
            },
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            curve: Curves.bounceIn,
            top: isMapExpanded ? -300 : 0,
            right: 0,
            left: 0,
            child: HomeTopSection(),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            bottom: isMapExpanded ? -400 : 0,
            right: 0,
            left: 0,
            child: HomeBottomSection(),
          ),
        ],
      ),
    );
  }
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

