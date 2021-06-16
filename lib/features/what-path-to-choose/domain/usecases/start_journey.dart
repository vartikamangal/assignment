// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/journey.dart';
import '../repositories/start_journey_service.dart';

class StartJourney implements Usecase<Success, StartJourneyParams> {
  final StartJourneyService service;

  StartJourney({
    @required this.service,
  });
  @override
  Future<Either<Failure, Success>> call(StartJourneyParams params) async {
    return service.startJourney(journey: params.journey);
  }
}

class StartJourneyParams extends Equatable {
  final Journey journey;

  const StartJourneyParams({@required this.journey});
  @override
  List<Object> get props => [journey];
}
