import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/domain/entities/app-duration.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class AppDurationRepository {
  Future<Either<Failure, Unit>> updateUserDurationOnApp({
    @required AppDuration appDuration,
    @required bool isNewUser,
  });
  Future<Either<Failure, AppDuration>> getLastLogin();
}
