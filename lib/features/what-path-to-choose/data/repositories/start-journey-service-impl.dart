// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../../../core/success/success-interface.dart';
import '../../domain/entites/journey.dart';
import '../../domain/repositories/start_journey_service.dart';
import '../models/journey-model.dart';
import '../sources/start-journey-remote-service.dart';

class StartJourneyServiceImpl implements StartJourneyService {
  final StartJourneyRemoteService remoteService;
  final NetworkInfo networkInfo;

  StartJourneyServiceImpl({
    @required this.remoteService,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, Success>> startJourney({Journey journey}) async {
    if (await networkInfo.isConnected) {
      try {
        final startedJourneyStatus = await remoteService.startJourney(
          journey: journey as JourneyModel,
        );
        return Right(startedJourneyStatus);
      } on AuthException {
        return const Left(
          AuthFailure(
            reason: 'You need to be logged in first',
            code: 'NA',
            smallMessage: 'No authentication header passed',
          ),
        );
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      } on CacheException {
        return Left(
          CacheFailure(),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
