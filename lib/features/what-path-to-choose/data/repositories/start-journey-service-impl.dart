// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

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
  final BaseRepository baseRepository;

  StartJourneyServiceImpl({
    @required this.remoteService,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, Success>> startJourney({Journey journey}) async {
    return baseRepository(
      () => remoteService.startJourney(
        journey: journey as JourneyModel,
      ),
    );
  }
}
