// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/activity-schedule-guided.dart';
import '../repositories/get-activity-schedule-for-guided-plan-repository.dart';

class GetActivityScheduleForGuidedPlan
    implements Usecase<ActivitySceduleGuided, NoParams> {
  final GetActivitySceduleForGuidedPlanRepository repository;

  GetActivityScheduleForGuidedPlan({
    required this.repository,
  });
  @override
  Future<Either<Failure, ActivitySceduleGuided>?> call(NoParams params) async {
    return repository.getSchedule();
  }
}
