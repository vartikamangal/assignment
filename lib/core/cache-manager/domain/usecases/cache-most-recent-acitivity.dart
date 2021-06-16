// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/cache-most-recent-acitivity-service.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class CacheMostRecentAcitivity
    implements Usecase<Unit, CacheMostRecentAcitivityParams> {
  final CacheMostRecentAcitivtyService service;

  CacheMostRecentAcitivity({
    @required this.service,
  });
  @override
  Future<Either<Failure, Unit>> call(
      CacheMostRecentAcitivityParams params) async {
    return service.cacheActivity(
      acitivity: params.acitivity,
    );
  }
}

class CacheMostRecentAcitivityParams extends Equatable {
  final CacheAcitivityModel acitivity;
  const CacheMostRecentAcitivityParams({
    @required this.acitivity,
  });
  @override
  List<Object> get props => [
        acitivity,
      ];
}
