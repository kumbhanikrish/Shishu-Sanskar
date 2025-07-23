import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shishu_sanskar/module/graph/model/daily_report_model.dart';
import 'package:shishu_sanskar/module/graph/model/weekly_report_model.dart';

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

class DayEntry {
  final String dayName;
  final Day data;

  DayEntry({required this.dayName, required this.data});
}

List<DayEntry> convertToDayList(Map<String, dynamic> json) {
  const List<String> orderedDays = [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
  ];

  const Map<String, String> displayDayNames = {
    'sunday': 'Sun',
    'monday': 'Mon',
    'tuesday': 'Tue',
    'wednesday': 'Wed',
    'thursday': 'Thu',
    'friday': 'Fri',
    'saturday': 'Sat',
  };

  return orderedDays.map((day) {
    final dayData =
        json[day] ?? {"tasks": 0, "completed_tasks": 0, "pending_tasks": 0};
    return DayEntry(
      dayName: displayDayNames[day] ?? day,
      data: Day.fromJson(dayData),
    );
  }).toList();
}

String formatTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final diff = now.difference(dateTime);

  if (diff.inMinutes < 10) {
    return 'Just now';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes} minutes ago';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} hours ago';
  } else {
    // Format date as dd MMM yyyy (e.g., 07 Jul 2025)
    return '${dateTime.day.toString().padLeft(2, '0')} '
        '${_monthName(dateTime.month)} '
        '${dateTime.year}';
  }
}

String _monthName(int month) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return months[month - 1];
}

List<DailyDateModel> generatePastDaysModel(int count) {
  final now = DateTime.now();
  List<DailyDateModel> days = [];

  for (int i = 0; i < count; i++) {
    final date = now.subtract(Duration(days: count - i - 1));
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final dayName = DateFormat('EEE').format(date); // e.g., Mon, Tue

    days.add(
      DailyDateModel(index: i + 1, date: formattedDate, dayName: dayName),
    );
  }

  return days;
}
