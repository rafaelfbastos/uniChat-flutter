import 'package:geolocator/geolocator.dart';
import 'package:unichat/app/core/helpers/environments.dart';

class Location {
  Location._();

  static Future<bool> geoBlock() async {
    if (Environments.boolParam("geo_block")!) {
      final currentPosition = await _determinePosition();

      final distanceInMeters = Geolocator.distanceBetween(
          Environments.doubleParam("center_latitude")!,
          Environments.doubleParam("center_longitude")!,
          currentPosition.latitude,
          currentPosition.longitude);
      return distanceInMeters <= 100;
    } else {
      return true;
    }
  }

  static Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
