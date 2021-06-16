import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class LogLastOpenedAppService {
  Future<Either<Failure, Unit>> logStartDatetime();
  Future<Either<Failure, DateTime>> retrieveLastLog();
}
