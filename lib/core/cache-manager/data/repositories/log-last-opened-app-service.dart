import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/app-last-opened-log-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/log-last-opened-app-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

class LogLastOpenedAppServiceImpl implements LogLastOpenedAppService {
  final AppLastOpenedLogLocalService localService;

  LogLastOpenedAppServiceImpl({
    @required this.localService,
  });
  @override
  Future<Either<Failure, Unit>> logStartDatetime() async {
    try {
      final result = await localService.logStartDatetime();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, DateTime>> retrieveLastLog() async {
    try {
      final result = await localService.retrieveLastLog();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
