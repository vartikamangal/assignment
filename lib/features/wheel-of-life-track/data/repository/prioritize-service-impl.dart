// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../../../core/success/success-interface.dart';
import '../../domain/entities/life-areas-for-prioritization.dart';
import '../../domain/repositories/prioritize-service.dart';
import '../models/life-area-model-for-prioritization.dart';
import '../sources/prioritize-remote-service.dart';

class PrioritizeServiceImpl implements PrioritizeService {
  final NetworkInfo networkInfo;
  final PrioritizeRemoteService remoteService;

  PrioritizeServiceImpl({
    @required this.networkInfo,
    @required this.remoteService,
  });
  @override
  Future<Either<Failure, Success>> prioritize({
    @required LifeAreaForPrioritization lifeAreas,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final prioritizeStatus = await remoteService.prioritize(
          lifeAreas: lifeAreas as LifeAreaModelForPrioritization,
        );
        return Right(prioritizeStatus);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
