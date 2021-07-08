// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/activity-schedule-guided.dart';
import '../../domain/repositories/get-activity-schedule-for-guided-plan-repository.dart';
import '../sources/get-activity-schedule-for-guided-plan-remote-data-source.dart';

class GetActivityScheduleGuidedPlanRepositoryImpl
    implements GetActivitySceduleForGuidedPlanRepository {
  final GetActivityScheduleForGuidedPlanRemoteDataSource? remoteDataSource;
  final BaseRepository baseRepository;

  GetActivityScheduleGuidedPlanRepositoryImpl({
    required this.remoteDataSource,
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, ActivitySceduleGuided>?> getSchedule() async {
    return baseRepository(
      () => remoteDataSource!.getSchedule(),
    );
  }
}
