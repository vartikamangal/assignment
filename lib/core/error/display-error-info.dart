import 'package:app_settings/app_settings.dart';
import 'failures.dart';
import '../utils/snackbars/snackbars.dart';

class ErrorInfo {
  static void show(Failure f) {
    if (f is AuthFailure) {
      ShowSnackbar.rawSnackBar(
        title: f.title,
        message: f.details,
        actionLabel: 'Dismiss',
        onActionPressed: () {},
      );
    }
    if (f is CacheFailure) {
      ShowSnackbar.rawSnackBar(
        title: 'Caching failed',
        message: 'Seems like cache is broken',
        actionLabel: 'Dismiss',
        onActionPressed: () {},
      );
    }
    if (f is ServerFailure) {
      ShowSnackbar.rawSnackBar(
        title: 'Server failure',
        message: 'Whoops! something went wrong on our side',
        actionLabel: 'Dismiss',
        onActionPressed: () {},
      );
    }
    if (f is NotPermittedActionFailure) {
      ShowSnackbar.rawSnackBar(
        title: 'Request denied',
        message: "Don't worry you can enable it again from settings",
        actionLabel: 'App Settings',
        onActionPressed: () async {
          await AppSettings.openAppSettings();
        },
      );
    }
    if (f is VoiceNoteFailure) {
      ShowSnackbar.rawSnackBar(
        title: 'Recording error',
        message: 'Whoops! seems like the voicenote is broken',
        actionLabel: 'Dismiss',
        onActionPressed: () {},
      );
    }
    if (f is DeviceOfflineFailure) {
      ShowSnackbar.rawSnackBar(
        title: 'Device offline',
        message: 'Please turn on your internet connection',
        actionLabel: 'Open Settings',
        onActionPressed: () async {
          await AppSettings.openDataRoamingSettings();
        },
      );
    }
    if (f is PlaybackFailure) {
      ShowSnackbar.rawSnackBar(
        title: "Can't play the voicenote",
        message: 'Seems there are some problems with the device storage',
        actionLabel: 'Open Settings',
        onActionPressed: () async {
          await AppSettings.openDataRoamingSettings();
        },
      );
    } else {
      ShowSnackbar.rawSnackBar(
        title: 'Unknown error',
        message: 'Something went wrong!',
        actionLabel: 'Dismiss',
        onActionPressed: () {},
      );
    }
  }
}
