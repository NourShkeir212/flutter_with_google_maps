import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {

  late CameraPosition initialCameraPosition;

  void initState() {
    initialCameraPosition = CameraPosition(
        zoom: 13, target: LatLng(33.48664680612372, 36.30252545175364,
    )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition: initialCameraPosition,
        cameraTargetBounds: CameraTargetBounds(
          LatLngBounds(
            southwest: LatLng(33.45, 36.2),
            northeast: LatLng(33.55, 36.35),
          ),
        )
    );
  }
}

// world view 0 -> 3
// country view 4 -> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20