import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../repositories/log-last-opened-app-service.dart';

class RetirieveLastLoggedAppInit implements Usecase<DateTime, NoParams> {
  final LogLastOpenedAppService service;

  RetirieveLastLoggedAppInit({
    required this.service,
  });
  @override
  Future<Either<Failure, DateTime>?> call(NoParams params) async {
    return service.retrieveLastLog();
  }
}
