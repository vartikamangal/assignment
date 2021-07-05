// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/repositories/path-operations-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/journey.dart';

class StartJourney implements Usecase<Success, StartJourneyParams> {
  final PathOperationsRepository service;

  StartJourney({
    required this.service,
  });
  @override
  Future<Either<Failure, Success>?> call(StartJourneyParams params) async {
    return service.startJourney(journey: params.journey);
  }
}

class StartJourneyParams extends Equatable {
  final Journey? journey;

  const StartJourneyParams({required this.journey});
  @override
  List<Object?> get props => [journey];
}
