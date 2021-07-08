// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-activity.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class GetRecommendationsByActionTimeRepository {
  Future<Either<Failure, List<ActivityRecommendation>>?> getRecommendations({
    required String actionTime,
  });
}
