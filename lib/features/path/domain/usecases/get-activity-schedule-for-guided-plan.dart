import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/activity-schedule-guided.dart';
import 'package:tatsam_app_experimental/features/path/domain/repositories/get-activity-schedule-for-guided-plan-repository.dart';

class GetActivityScheduleForGuidedPlan
    implements Usecase<ActivitySceduleGuided, NoParams> {
  final GetActivitySceduleForGuidedPlanRepository repository;

  GetActivityScheduleForGuidedPlan({
    @required this.repository,
  });
  @override
  Future<Either<Failure, ActivitySceduleGuided>> call(NoParams params) async {
    return repository.getSchedule();
  }
}
