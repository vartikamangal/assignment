import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/activity-schedule-guided.dart';

abstract class GetActivitySceduleForGuidedPlanRepository {
  Future<Either<Failure, ActivitySceduleGuided>> getSchedule();
}
