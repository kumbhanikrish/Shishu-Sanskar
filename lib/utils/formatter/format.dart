import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<String?> getCityName() async {
  LocationPermission permission;

  // Check if location services are enabled
  await Geolocator.isLocationServiceEnabled();

  // Check for permissions
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return 'Location permissions are denied.';
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return 'Location permissions are permanently denied.';
  }

  // Get current position
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // Get placemarks (address) from coordinates
  List<Placemark> placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );

  if (placemarks.isNotEmpty) {
    return placemarks.first.locality; // This gives you the city name
  }

  return 'City not found.';
}

Future<String> getDeviceName() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return '${androidInfo.manufacturer} ${androidInfo.model}';
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return '${iosInfo.name} (${iosInfo.model})';
  } else {
    return 'Unknown Device';
  }
}
