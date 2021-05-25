import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/features/path/data/sources/get-activity-schedule-for-guided-plan-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/activity-schedule-guided.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/path/domain/repositories/get-activity-schedule-for-guided-plan-repository.dart';

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
