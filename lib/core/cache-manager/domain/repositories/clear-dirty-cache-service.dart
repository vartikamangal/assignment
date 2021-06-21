import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class ClearDirtyCacheService {
  Future<Either<Failure, Unit>> clearCache();
}
