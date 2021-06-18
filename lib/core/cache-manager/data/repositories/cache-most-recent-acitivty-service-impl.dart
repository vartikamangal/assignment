// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/cache-most-recent-activity-local-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/cache-most-recent-acitivity-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

class CacheMostRecentActivityServiceImpl
    implements CacheMostRecentAcitivtyService {
  final CacheMostRecentAcitivityLocalService localService;

  CacheMostRecentActivityServiceImpl({
    @required this.localService,
  });
  @override
  Future<Either<Failure, Unit>> cacheActivity({
    CacheAcitivityModel acitivity,
  }) async {
    try {
      final cacheStatus = await localService.cacheActivity(
        acitivity: acitivity,
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
