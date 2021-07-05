// Package imports:
import 'package:dartz/dartz.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class RetrieveUserPathRepository {
  Future<Either<Failure, String>?> retrievePath();
}
