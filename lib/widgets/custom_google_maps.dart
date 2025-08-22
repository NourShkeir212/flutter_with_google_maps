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
  dispose(){
    googleMapController.dispose();
    super.dispose();
  }

  // للتحكم ب غوغل ماب
  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GoogleMap(
            // لإعطاء الكونترولر الى غوغل ماب
            onMapCreated: (controller) {
              googleMapController = controller;
            },
              initialCameraPosition: initialCameraPosition,
              cameraTargetBounds: CameraTargetBounds(
                LatLngBounds(
                  southwest: LatLng(33.45, 36.2),
                  northeast: LatLng(33.55, 36.35),
                ),
              )
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
                onPressed: (){

                  googleMapController.animateCamera(CameraUpdate.newLatLng(LatLng(33.445862511561614, 36.26707881710544)));
                },
                child: Text('Change Location')
            ),
          )
        ],
      ),
    );
  }
}

// world view 0 -> 3
// country view 4 -> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20