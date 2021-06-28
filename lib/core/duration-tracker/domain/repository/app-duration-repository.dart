import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../entities/app-duration.dart';
import '../../../error/failures.dart';

abstract class AppDurationRepository {
  Future<Either<Failure, Unit>> updateUserDurationOnApp({
    @required AppDuration appDuration,
    @required bool isNewUser,
  });
  Future<Either<Failure, AppDuration>> getLastLogin();
}
