import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import '../entities/mood.dart';
import '../entities/rapport-building-steps.dart';

abstract class GetRapportBuildingStepsRepository {
  Future<Either<Failure, RapportBuildingSteps>> getRapportBuildingSteps({
    @required Mood mood,
  });
}
