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
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

class RetreieveMostRecentAcitvityRepositoryImpl
    implements RetrieveMostRecentAcitivityRepository {
  final RetrieveMostRecentActivityLocalDataSource localDataSource;
  final BaseRepository baseRepository;

  RetreieveMostRecentAcitvityRepositoryImpl({
    @required this.localDataSource,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, CacheAcitivityModel>> retrieveActivity() async {
    return baseRepository(
      () => localDataSource.retrieveActivity(),
    );
  }
}
