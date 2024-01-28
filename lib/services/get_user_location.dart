import 'package:geolocator/geolocator.dart';

class LocationProvider {
  static Future<Position> determineUserLocation() async {
    /// check for location service state
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      /// Location services are not enabled
      return Future.error('Location services are disabled.');
    }

    /// get location permission for app
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        /// Permissions are denied
        return Future.error('Location permissions are denied');
      }
    }

    /// couldn't get location permission
    if (permission == LocationPermission.deniedForever) {
      /// Permissions are permanently denied
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
