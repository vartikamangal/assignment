// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/activity-schedule-guided.dart';
import '../../domain/repositories/get-activity-schedule-for-guided-plan-repository.dart';
import '../sources/get-activity-schedule-for-guided-plan-remote-data-source.dart';

class GetActivityScheduleGuidedPlanRepositoryImpl
    implements GetActivitySceduleForGuidedPlanRepository {
  final GetActivityScheduleForGuidedPlanRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetActivityScheduleGuidedPlanRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, ActivitySceduleGuided>> getSchedule() async {
    if (await networkInfo.isConnected) {
      try {
        final schedule = await remoteDataSource.getSchedule();
        return Right(schedule);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
