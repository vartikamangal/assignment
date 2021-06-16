// Dart imports:
import 'dart:math';

//import 'package:platform_device_id/platform_device_id.dart';

//! Uncomment for production
// Future<String> getDeviceId() async => PlatformDeviceId.getDeviceId;

//! Comment it out for production
Future<String> getDeviceId() async {
  final Random random = Random();
  String testDeviceId = '';
  for (int i = 0; i <= 6; i++) {
    // ignore: use_string_buffers
    testDeviceId += random.nextInt(100).toString();
  }
  return testDeviceId;
}
