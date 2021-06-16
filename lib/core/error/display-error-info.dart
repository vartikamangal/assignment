import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/utils/snackbars/snackbars.dart';

class ErrorInfo {
  static void show(Failure f) {
    if (f is AuthFailure) {
      ShowSnackbar.rawSnackBar(
        title: f.title,
        message: f.details,
      );
    }
    if (f is CacheFailure) {
      ShowSnackbar.rawSnackBar(
        title: 'Caching failed',
        message: 'Seems like cache is broken',
      );
    }
    if (f is ServerFailure) {
      ShowSnackbar.rawSnackBar(
        title: 'Server failure',
        message: 'Whoops! something went wrong on our side',
      );
    }
    if (f is NotPermittedActionFailure) {
      ShowSnackbar.rawSnackBar(
        title: 'Request denied',
        message: "Don't worry you can enable it again from settings",
      );
    }
    if (f is VoiceNoteFailure) {
      ShowSnackbar.rawSnackBar(
        title: 'Recording error',
        message: 'Whoops! seems like the voicenote is broken',
      );
    } else {
      ShowSnackbar.rawSnackBar(
        title: 'Unknown error',
        message: 'Something went wrong!',
      );
    }
  }
}
