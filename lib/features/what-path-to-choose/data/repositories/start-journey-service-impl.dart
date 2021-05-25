import '../../../../core/error/exceptions.dart';
import '../../../../core/platform/network_info.dart';
import '../models/journey-model.dart';
import '../sources/start-journey-remote-service.dart';
import '../../domain/entites/journey.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/start_journey_service.dart';
import 'package:flutter/foundation.dart';

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
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
