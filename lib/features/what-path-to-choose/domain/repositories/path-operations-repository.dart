import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/entites/journey.dart';

abstract class PathOperationsRepository {
  Future<Either<Failure, List<Journey>>?> getJourneyPaths();
  Future<Either<Failure, Success>?> startJourney({
    required Journey? journey,
  });
}
