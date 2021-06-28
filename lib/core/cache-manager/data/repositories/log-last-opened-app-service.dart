import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../services/app-last-opened-log-service.dart';
import '../../domain/repositories/log-last-opened-app-service.dart';
import '../../../error/exceptions.dart';
import '../../../error/failures.dart';
import '../../../repository/base-repository-impl.dart';

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
