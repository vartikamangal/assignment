// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class SaveUserOnboardingStatusService {
  Future<Either<Failure, Unit>> saveStatus({
    @required String onBoardingStatus,
  });
  Future<Either<Failure, String>> fetchStatus();
  Future<Either<Failure, Unit>> saveIsFirstTimeOnboardingStatus({
    @required String onBoardingStatus,
  });
  Future<Either<Failure, bool>> checkIfFirstTimeUser();
}
