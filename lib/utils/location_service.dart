import 'package:location/location.dart';

class LocationService {

  // ----------- Locations Guide-----------
/*
   1. inquire about location service
   2. request permission from user
   3. get location
   4. display
 */
  Location location = Location();

  //1. inquire about location service
  Future<bool> checkAndRequestLocationService() async {
    // check if the location enabled
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        return false;
      }
    }

    return true;
  }

  //2. request permission from user
  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      return permissionStatus == PermissionStatus.granted;
    }


    return true;
  }

  //3. get location
  void getRealTimeLocationData(void Function(LocationData)? onData) {
    // when the user move 2 meter new data come
    location.changeSettings(
      distanceFilter: 2
    );
    location.onLocationChanged.listen(onData);
  }
}