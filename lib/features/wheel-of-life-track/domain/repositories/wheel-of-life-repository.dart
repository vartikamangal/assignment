import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/life-area.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/life-areas-for-prioritization.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/rating-scale.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/satisfaction-ratings.dart';

abstract class WheelOfLifeRepository {
  Future<Either<Failure, List<LifeArea>>?> getLifeAreas();
  Future<Either<Failure, RatingScale>?> getRatingScale();
  Future<Either<Failure, Success>?> prioritize({
    required LifeAreaForPrioritization lifeAreas,
  });
  Future<Either<Failure, Success>?> rateSatisfactionService({
    required SatisfactionRatings satisfactionRatings,
  });
}
