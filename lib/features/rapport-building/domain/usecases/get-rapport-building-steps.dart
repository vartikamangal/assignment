// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/mood.dart';
import '../entities/rapport-building-steps.dart';

// returns new steps based on this mood
class GetRapportBuildingSteps
    implements Usecase<RapportBuildingSteps, GetRapportBuildingStepsParams> {
  final RapportBuildingRepository repository;

  GetRapportBuildingSteps({required this.repository});
  @override
  Future<Either<Failure, RapportBuildingSteps>?> call(
      GetRapportBuildingStepsParams params) async {
    return repository.getRapportBuildingSteps(
      mood: params.mood,
    );
  }
}

class GetRapportBuildingStepsParams extends Equatable {
  final Mood mood;

  const GetRapportBuildingStepsParams({
    required this.mood,
  });
  @override
  List<Object> get props => [mood];
}
