import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/mood.dart';
import '../entities/rapport-building-steps.dart';
import '../repositories/get-rapport-building-steps-repository.dart';
import 'package:flutter/foundation.dart';

// returns new steps based on this mood
class GetRapportBuildingSteps
    implements Usecase<RapportBuildingSteps, GetRapportBuildingStepsParams> {
  final GetRapportBuildingStepsRepository repository;

  GetRapportBuildingSteps({@required this.repository});
  @override
  Future<Either<Failure, RapportBuildingSteps>> call(
      GetRapportBuildingStepsParams params) async {
    return repository.getRapportBuildingSteps(
      mood: params.mood,
    );
  }
}

class GetRapportBuildingStepsParams extends Equatable {
  final Mood mood;

  const GetRapportBuildingStepsParams({
    @required this.mood,
  });
  @override
  List<Object> get props => [mood];
}
