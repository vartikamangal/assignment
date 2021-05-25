import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/features/path/data/sources/start-activity-remote-service.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/features/path/domain/repositories/start-activity-service.dart';

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
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final activtyStatus = await remoteService.startActivity(
          recommendationId: recommendationId,
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
