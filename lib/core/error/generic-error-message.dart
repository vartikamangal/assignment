import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class GenericErrorMessage {
  static const AuthFailure authFailure = AuthFailure(
    code: 'xxx',
    smallMessage: 'UnAuthorised request',
    reason: 'Seems like auth header has problems',
  );
  GenericErrorMessage._();
}
