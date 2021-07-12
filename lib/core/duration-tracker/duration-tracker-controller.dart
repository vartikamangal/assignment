// Dart imports:
import 'dart:async';

import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/domain/usecases/get-last-login.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/domain/usecases/update-user-duration-on-app.dart';

class DurationTrackerController extends GetxController {
  // usecases
  final GetLastLogin? getLastLogin;
  final UpdateUserDurationOnApp? updateUserDurationOnApp;

  DurationTrackerController({
    required this.getLastLogin,
    required this.updateUserDurationOnApp,
  });
  // reactive data holders

  // usecase helpers

  // ui managers

  ////////// STOPWATCH LOGIC /////////////

  // Instance of stopwatch
  final Stopwatch _stopwatch = Stopwatch();
  // Reactive elapsed storage component
  final Rxn<Duration> _elapsed = Rxn<Duration>();

  // getter for duration
  int get durationInMinutes => _elapsed.value?.inMinutes ?? 0;

  void start() {
    _stopwatch.start();
    // Refreshes the timer after 1 second
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _elapsed.value = _stopwatch.elapsed;
      },
    );
  }

  void stop() {
    _stopwatch.stop();
  }

  void reset() {
    _stopwatch.reset();
    _elapsed.value = _stopwatch.elapsed;
  }
}
