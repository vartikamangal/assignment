import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../repositories/log-last-opened-app-service.dart';
import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';

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
