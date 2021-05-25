import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../entites/journey.dart';

abstract class StartJourneyService {
  Future<Either<Failure, Success>> startJourney({
    @required Journey journey,
  });
}
