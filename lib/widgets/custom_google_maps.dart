import 'package:flutter/material.dart';
import 'package:flutter_maps/utils/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;
  late LocationService locationService;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      zoom: 1,
      target: LatLng(33.48664680612372, 36.30252545175364),
    );
    locationService = LocationService();
    updateMyLocation();
    super.initState();
  }

  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    bool hasPermission = await locationService
        .checkAndRequestLocationPermission();
    // we didn't put "await" to it because its the last method ,
    // the two method before it we need them to finish before we do the last one
    if (hasPermission) {
      locationService.getRealTimeLocationData((locationData) {
        LatLng myLocation = LatLng(
            locationData.latitude!, locationData.longitude!);
        setMyCameraPosition(myLocation);
        setMyLocationMarker(myLocation);
      });
    } else {
      // TODO: SHOW SNACK BAR
    }
  }

  void setMyCameraPosition(LatLng myLocation) {
    if (isFirstCall) {
      CameraPosition cameraPosition = CameraPosition(
        target: myLocation,
        zoom: 17,
      );
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
      isFirstCall = false;
    } else {
      googleMapController?.animateCamera(
        CameraUpdate.newLatLng(myLocation),
      );
    }
  }

  void setMyLocationMarker(LatLng myLocation) {
    var myLocationMarker = Marker(
      markerId: MarkerId(
        "myLocationMarker",
      ),
      position: myLocation,
    );

    markers.add(myLocationMarker);
    setState(() {});
  }

  void initMapStyle() async {
    //to provide new style we need
    // 1. load json file
    var lightMapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString("assets/map_styles/light_map_style.json");
    // 2. update Style
    googleMapController!.setMapStyle(lightMapStyle);
  }


  @override
  dispose() {
    googleMapController!.dispose();
    super.dispose();
  }


  bool isFirstCall = true;

  // للتحكم ب غوغل ماب
  GoogleMapController? googleMapController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMap(
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        // لإعطاء الكونترولر الى غوغل ماب
        onMapCreated: (controller) {
          googleMapController = controller;
          initMapStyle();
        },
        initialCameraPosition: initialCameraPosition,
        cameraTargetBounds: CameraTargetBounds(
          LatLngBounds(
            southwest: LatLng(33.45, 36.2),
            northeast: LatLng(33.55, 36.35),
          ),
        ),
      ),
    );
  }
}


// -------- Map View -------------

// world view 0 -> 3
// country view 4 -> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20


// -------------- FOR CHANGE ICON SIZE ------------ //
// Future<Uint8List> getImageFromRowData(String image , double width)async {
//   var imageData = await rootBundle.load(image);
//   var imageCodec = await ui.instantiateImageCodec(
//       imageData.buffer.asUint8List(),
//       targetWidth: width.round()
//   );
//   var imageFrameInfo = await imageCodec.getNextFrame();
//
//   var imageByteData = await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);
//
//   return imageByteData!.buffer.asUint8List();
// }