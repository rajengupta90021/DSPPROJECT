import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LocationService {
  Future<void> checkPermission(Function(String, String) onLocationFetched) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
        msg: 'Location services are disabled. Please enable them in settings.',
        toastLength: Toast.LENGTH_LONG,

      );
      await Geolocator.openLocationSettings();
      return;
    }

    // Check current location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permission denied. Please enable it in settings.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Location permission permanently denied. Please enable it in settings.');
      return;
    }

    // Permissions are granted, proceed to fetch location
    await getLocation(onLocationFetched);
  }

  Future<void> getLocation(Function(String, String) onLocationFetched) async {
    try {
      // Get the current position with high accuracy
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      // Format coordinates
      String coordinates = 'Latitude: ${position.latitude}\nLongitude: ${position.longitude}';

      // Reverse geocode the coordinates to get the address
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      String address = placemarks.isNotEmpty
          ? '${placemarks[0].name}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}'
          : 'No address found';

      // Pass the location and address to the callback function
      onLocationFetched(coordinates, address);
    } catch (e) {
      // Log detailed error to console for debugging
      print("Error occurred while fetching location: $e");

      // Show user-friendly message via toast
      Fluttertoast.showToast(msg: "Failed to fetch location. Please try again later.");
    }
  }
}
