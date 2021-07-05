import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';

abstract class LogLastOpenedAppService {
  Future<Either<Failure, Unit>?> logStartDatetime();
  Future<Either<Failure, DateTime>?> retrieveLastLog();
}
