import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({
    required this.id,
    required this.name,
    required this.latLng,
  });
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'Al-ashmar masjed',
    latLng: LatLng(33.48773079891359,36.30227789564415),
  ),
  PlaceModel(
    id: 2,
    name: 'Alaa House',
    latLng: LatLng(33.43400203803081,36.279805334983585),
  ),
  PlaceModel(
    id: 3,
    name: 'Ebla Sox',
    latLng: LatLng(33.44597321739947,36.267128760909564),
  ),
];
