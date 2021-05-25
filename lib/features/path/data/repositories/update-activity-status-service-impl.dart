import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/features/path/data/sources/update-activity-status-remote-sevice.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/path/domain/repositories/update-activity-status-service.dart';

class UpdateActivityStatusServiceImpl implements UpdateActivityStatusService {
  final UpdateActivityStatusRemoteService remoteService;
  final NetworkInfo networkInfo;

  UpdateActivityStatusServiceImpl({
    @required this.remoteService,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, ActivityStatus>> updateStatus({
    String status,
    int actionId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final activityStatus = await remoteService.modifyStatus(
          status: status,
          actionId: actionId,
        );
        return Right(activityStatus);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
