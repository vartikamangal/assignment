// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/feeling-duration.dart';

abstract class GetAvailableFeelingDurationRepository {
  Future<Either<Failure, List<FeelingDuration>>> getAvailableDurations();
}
