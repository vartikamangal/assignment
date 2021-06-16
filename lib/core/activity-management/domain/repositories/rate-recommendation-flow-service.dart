// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class RateRecommendationFlowService {
  Future<Either<Failure, Unit>> rateRecommendation({
    @required FeedbackModel feedback,
  });
}
