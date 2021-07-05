import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../repositories/log-last-opened-app-service.dart';

class LogAppStartTime implements Usecase<Unit, NoParams> {
  final LogLastOpenedAppService service;

  LogAppStartTime({
    required this.service,
  });
  @override
  Future<Either<Failure, Unit>?> call(NoParams params) async {
    return service.logStartDatetime();
  }
}
