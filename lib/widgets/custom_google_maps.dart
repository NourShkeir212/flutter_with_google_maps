import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_maps/model/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      zoom: 12,
      target: LatLng(33.48664680612372, 36.30252545175364),
    );
    initMarkers();
    initPolyLines();
    initPolyGon();
    super.initState();
  }

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


  void initMarkers() async {
    BitmapDescriptor customMarkerIcon = await BitmapDescriptor.asset(ImageConfiguration(size: Size(25, 25)),"assets/icons/marker.png",);
    var myMarkers = places.map((placeModel) =>
        Marker(
            icon: customMarkerIcon,
            infoWindow: InfoWindow(
              title: placeModel.name,
            ),
            markerId: MarkerId(
              placeModel.id.toString(),
            ),
            position: placeModel.latLng,
            onTap: () {
              print(placeModel.name);
            }
        ),
    ).toSet();
    markers.addAll(myMarkers);
    setState(() {

    });
  }

  // لرسم مسار
  void initPolyLines() {
    Polyline polyline = const Polyline(
      width: 3,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        color: Colors.red,
        polylineId: PolylineId("1"),
        points: [
          LatLng(33.48773079891359,36.30227789564415),
          LatLng(33.43400203803081,36.279805334983585),
        ]
    );
    polyLines.add(polyline);
  }

  // لرسم اشكال او تحديد منطقة 
  void initPolyGon() {
    Polygon polygon =  Polygon(
      strokeWidth:3,
      strokeColor: Colors.orange,
      fillColor: Colors.orange.withOpacity(0.4),
        polygonId: PolygonId("1"),
        points: [
          LatLng(33.48773079891359,36.30227789564415),
          LatLng(33.43400203803081,36.279805334983585),
          LatLng(33.44597321739947,36.267128760909564),
        ]
    );
    polygons.add(polygon);
  }
  
  Set<Polyline> polyLines = {};
  Set<Polygon> polygons = {};
  Set<Marker> markers = {};
  void initMapStyle() async {
    //to provide new style we need
    // 1. load json file
    var lightMapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString("assets/map_styles/light_map_style.json");
    // 2. update Style
    googleMapController.setMapStyle(lightMapStyle);
  }

  @override
  dispose() {
    googleMapController.dispose();
    super.dispose();
  }
  
  // للتحكم ب غوغل ماب
  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMap(
        polygons: polygons,
        polylines: polyLines,
        zoomControlsEnabled: false,
        markers: markers,
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

// world view 0 -> 3
// country view 4 -> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20
