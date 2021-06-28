// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/cache-manager/data/services/user-onboarding-status-local-service.dart';
import '../../domain/repositories/user-onboarding-status-repository.dart';
import '../../../../core/error/failures.dart';

class SaveUserOnboardingStatusServiceImpl
    implements UserOnboardingStatusRepository {
  final UserOnboardingStatusLocalService localService;
  final BaseRepository baseRepository;

  SaveUserOnboardingStatusServiceImpl({
    @required this.localService,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, String>> fetchStatus() async {
    return baseRepository(
      () => localService.fetchStatus(),
    );
  }

  @override
  Future<Either<Failure, Unit>> saveStatus({
    String onBoardingStatus,
  }) async {
    return baseRepository(
      () => localService.saveStatus(
        status: onBoardingStatus,
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> checkIfFirstTimeUser() async {
    return baseRepository(
      () => localService.checkIsFirstTimeUser(),
    );
  }

  @override
  Future<Either<Failure, Unit>> saveIsFirstTimeOnboardingStatus(
      {String onBoardingStatus}) async {
    return baseRepository(
      () => localService.saveIsFirstTimeUser(
        onBoardingStatus: onBoardingStatus,
      ),
    );
  }
}
