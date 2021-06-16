// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/mood.dart';
import '../entities/rapport-building-steps.dart';

abstract class GetRapportBuildingStepsRepository {
  Future<Either<Failure, RapportBuildingSteps>> getRapportBuildingSteps({
    @required Mood mood,
  });
}
