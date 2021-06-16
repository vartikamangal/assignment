// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/activity-schedule-guided.dart';

abstract class GetActivitySceduleForGuidedPlanRepository {
  Future<Either<Failure, ActivitySceduleGuided>> getSchedule();
}
