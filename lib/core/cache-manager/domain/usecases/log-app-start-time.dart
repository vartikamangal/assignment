import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/log-last-opened-app-service.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class LogAppStartTime implements Usecase<Unit, NoParams> {
  final LogLastOpenedAppService service;

  LogAppStartTime({
    @required this.service,
  });
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return service.logStartDatetime();
  }
}
