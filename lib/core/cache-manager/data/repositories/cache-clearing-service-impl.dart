import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/cache-clearing-local-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/cache-clearing-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

class CacheClearingServiceImpl implements CacheClearingService {
  final CacheClearingLocalService localService;

  CacheClearingServiceImpl({@required this.localService});
  @override
  Future<Either<Failure, Unit>> clearDirtyCacheOnFirstRun() async {
    try {
      await localService.clearDirtyCacheOnFirstRun();
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
