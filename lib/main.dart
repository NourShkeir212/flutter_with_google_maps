import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'widgets/custom_google_maps.dart';

void main(){
  runApp(TestsGoogleMapsWithFlutter());
}

class TestsGoogleMapsWithFlutter extends StatelessWidget {
  const TestsGoogleMapsWithFlutter({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomGoogleMaps(),
    );
  }
}
