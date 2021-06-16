// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/retrieve-most-recent-activity-repository.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class RetrieveMostRecentActivity
    implements Usecase<CacheAcitivityModel, NoParams> {
  final RetrieveMostRecentAcitivityRepository repository;

  RetrieveMostRecentActivity({
    @required this.repository,
  });
  @override
  Future<Either<Failure, CacheAcitivityModel>> call(NoParams params) async {
    return repository.retrieveActivity();
  }
}
