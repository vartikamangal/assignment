// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/cache-most-recent-activity-local-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/cache-most-recent-acitivity-service.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

class CacheMostRecentActivityServiceImpl
    implements CacheMostRecentAcitivtyService {
  final CacheMostRecentAcitivityLocalService localService;
  final BaseRepository baseRepository;

  CacheMostRecentActivityServiceImpl({
    @required this.localService,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, Unit>> cacheActivity({
    CacheAcitivityModel acitivity,
  }) async {
    return baseRepository(
      () => localService.cacheActivity(
        acitivity: acitivity,
      ),
    );
  }
}
