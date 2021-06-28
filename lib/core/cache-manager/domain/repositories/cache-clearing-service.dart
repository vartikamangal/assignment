import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class CacheClearingService {
  Future<Either<Failure, Unit>> clearDirtyCacheOnFirstRun();
}
