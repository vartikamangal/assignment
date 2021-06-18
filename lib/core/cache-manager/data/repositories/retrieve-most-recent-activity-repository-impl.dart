// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/retrieve-most-recent-activity-local-data-source.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/retrieve-most-recent-activity-repository.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

class RetreieveMostRecentAcitvityRepositoryImpl
    implements RetrieveMostRecentAcitivityRepository {
  final RetrieveMostRecentActivityLocalDataSource localDataSource;

  RetreieveMostRecentAcitvityRepositoryImpl({
    @required this.localDataSource,
  });
  @override
  Future<Either<Failure, CacheAcitivityModel>> retrieveActivity() async {
    try {
      final cachedActivity = await localDataSource.retrieveActivity();
      return Right(
        cachedActivity,
      );
    } on CacheException {
      return Left(
        CacheFailure(),
      );
    }
  }
}
