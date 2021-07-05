import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../entities/app-duration.dart';

abstract class AppDurationRepository {
  Future<Either<Failure, Unit>> updateUserDurationOnApp({
    required AppDuration appDuration,
    required bool isNewUser,
  });
  Future<Either<Failure, AppDuration>> getLastLogin();
}
