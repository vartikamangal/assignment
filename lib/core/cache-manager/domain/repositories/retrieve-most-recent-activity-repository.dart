// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class RetrieveMostRecentAcitivityRepository {
  Future<Either<Failure, CacheAcitivityModel>> retrieveActivity();
}
