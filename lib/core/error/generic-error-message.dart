import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class GenericErrorMessage {
  static const AuthFailure authFailure = AuthFailure(
    title: 'Authentication error',
    details: 'Seems like you are not logged in',
  );
  GenericErrorMessage._();
}
