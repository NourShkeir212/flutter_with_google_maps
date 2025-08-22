import 'package:flutter/material.dart';
import 'package:flutter_maps/model/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    super.initState();
  }

  void initMarkers() async {
    var myMarkers = places.map((placeModel) =>
        Marker(
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
  }

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
