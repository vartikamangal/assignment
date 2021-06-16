// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../entites/journey.dart';

abstract class StartJourneyService {
  Future<Either<Failure, Success>> startJourney({
    @required Journey journey,
  });
}
