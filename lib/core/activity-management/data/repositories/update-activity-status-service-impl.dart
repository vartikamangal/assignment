// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/activity-status.dart';
import '../../domain/repositories/update-activity-status-service.dart';
import '../sources/update-activity-status-remote-sevice.dart';

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
