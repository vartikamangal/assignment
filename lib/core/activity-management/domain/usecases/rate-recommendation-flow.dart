// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/repositories/rate-recommendation-flow-service.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class RateRecommendationFlow
    implements Usecase<Unit, RateRecommendationFlowParams> {
  final RateRecommendationFlowService service;

  RateRecommendationFlow({
    @required this.service,
  });
  @override
  Future<Either<Failure, Unit>> call(
      RateRecommendationFlowParams params) async {
    return service.rateRecommendation(
      feedback: params.feedback,
    );
  }
}

class RateRecommendationFlowParams extends Equatable {
  final FeedbackModel feedback;
  const RateRecommendationFlowParams({
    @required this.feedback,
  });
  @override
  List<Object> get props {
    return [feedback];
  }
}
