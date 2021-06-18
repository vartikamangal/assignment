// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/cache-manager/data/services/user-onboarding-status-local-service.dart';
import '../../../../core/cache-manager/domain/repositories/save-user-onboarding-status-service.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class SaveUserOnboardingStatusServiceImpl
    implements SaveUserOnboardingStatusService {
  final UserOnboardingStatusLocalService localService;

  SaveUserOnboardingStatusServiceImpl({
    @required this.localService,
  });
  @override
  Future<Either<Failure, String>> fetchStatus() async {
    try {
      final onBoardingStatus = await localService.fetchStatus();
      return Right(
        onBoardingStatus,
      );
    } on CacheException {
      return Left(
        CacheFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> saveStatus({
    String onBoardingStatus,
  }) async {
    try {
      final cacheStatus = await localService.saveStatus(
        status: onBoardingStatus,
      );
      return Right(
        cacheStatus,
      );
    } on CacheException {
      return Left(
        CacheFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfFirstTimeUser() async {
    try {
      final isFirstTimeUser = await localService.checkIsFirstTimeUser();
      return Right(
        isFirstTimeUser,
      );
    } on CacheException {
      return Left(
        CacheFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> saveIsFirstTimeOnboardingStatus(
      {String onBoardingStatus}) async {
    try {
      final cacheStatus = await localService.saveIsFirstTimeUser(
        onBoardingStatus: onBoardingStatus,
      );
      return Right(
        cacheStatus,
      );
    } on CacheException {
      return Left(
        CacheFailure(),
      );
    }
  }
}
