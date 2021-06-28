// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class UserOnboardingStatusRepository {
  /// Responsible for saving the status of onboarded user
  /// User is marked onboarded once he sees the
  /// onboarding screen
  Future<Either<Failure, Unit>> saveStatus({
    @required String onBoardingStatus,
  });

  /// Responsible for fetching the status of user onboarded or not
  /// Returns [String] "YES" --> User onboarded or "NO" --> User not onboarded
  Future<Either<Failure, String>> fetchStatus();

  /// Marks wheaher or not the user is seeing
  /// the onboarding screen for the first time
  Future<Either<Failure, Unit>> saveIsFirstTimeOnboardingStatus({
    @required String onBoardingStatus,
  });

  /// Responsible for fetching a [bool] stating wheather the
  /// user has opened app for the first time
  Future<Either<Failure, bool>> checkIfFirstTimeUser();
}
