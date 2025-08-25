import 'package:flutter/material.dart';
import 'widgets/google_map_view.dart';

void main() {
  runApp(RouteTrackerApp());
}

class RouteTrackerApp extends StatelessWidget {
  const RouteTrackerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleMapView(),
    );
  }
}
