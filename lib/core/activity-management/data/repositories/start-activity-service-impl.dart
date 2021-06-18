// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/activity-status.dart';
import '../../domain/repositories/start-activity-service.dart';
import '../sources/start-activity-remote-service.dart';

class StartActivityServiceImpl implements StartActivityService {
  final StartActivityRemoteService remoteService;
  final NetworkInfo networkInfo;

  StartActivityServiceImpl({
    @required this.remoteService,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, ActivityStatus>> startActivity({
    String recommendationId,
    bool isInstantActivity,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final activtyStatus = await remoteService.startActivity(
          recommendationId: recommendationId,
          isInstantActivity: isInstantActivity,
        );
        return Right(activtyStatus);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
