import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      // Request permission if it is denied
      await Permission.location.request();
      // Update status after requesting
      status =
          await Permission.location.status; 
    }

    if (status.isPermanentlyDenied) {
      // Open app settings if permission is permanently denied
      openAppSettings();
      return Future.error('Location permission is permanently denied.');
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location Services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permission is denied.');
    }

    // If all checks pass, return the current position
    return await Geolocator.getCurrentPosition();
  }

Future<String> decodeCoordinates(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    // Handle cases where no placemarks are found
    if (placemarks.isEmpty) {
      return 'No location information found for these coordinates.';
    }

    Placemark place = placemarks[0];

    // Build the address string with optional components
    String address = '';
    if (place.thoroughfare != null) {
      address += '${place.thoroughfare}, ';
    }
    if (place.subLocality != null) {
      address += '${place.subLocality}, ';
    }
    if (place.locality != null) {
      address += '${place.locality}, ';
    }
    if (place.administrativeArea != null) {
      address += '${place.administrativeArea}, ';
    }
    if (place.country != null) {
      address += place.country!;
    }
    // Remove trailing comma if present
    address = address.trimRight().replaceAll(RegExp(r',\s*$'), '');

    return address.isEmpty ? 'Unknown Location' : address;
  } catch (e) {
    print('Error: $e');
    return 'Error decoding coordinates.';
  }
}

Future<String> getCityNameFromCoordinates(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    // Handle cases where no placemarks are found
    if (placemarks.isEmpty) {
      return 'No location information found for these coordinates.';
    }

    Placemark place = placemarks[0];

    // Return the city name
    return place.locality ?? 'Unknown City';
  } catch (e) {
    print('Error: $e');
    return 'Error decoding coordinates.';
  }
}


}
