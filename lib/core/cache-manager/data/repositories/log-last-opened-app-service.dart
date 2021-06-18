import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/app-last-opened-log-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/log-last-opened-app-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

class LogLastOpenedAppServiceImpl implements LogLastOpenedAppService {
  final AppLastOpenedLogLocalService localService;
  final BaseRepository baseRepository;

  LogLastOpenedAppServiceImpl({
    @required this.localService,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, Unit>> logStartDatetime() async {
    return baseRepository(
      () => localService.logStartDatetime(),
    );
  }

  @override
  Future<Either<Failure, DateTime>> retrieveLastLog() async {
    return baseRepository(
      () => localService.retrieveLastLog(),
    );
  }
}
