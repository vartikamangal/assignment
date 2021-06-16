import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/log-last-opened-app-service.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class RetirieveLastLoggedAppInit implements Usecase<DateTime, NoParams> {
  final LogLastOpenedAppService service;

  RetirieveLastLoggedAppInit({
    @required this.service,
  });
  @override
  Future<Either<Failure, DateTime>> call(NoParams params) async {
    return service.retrieveLastLog();
  }
}
