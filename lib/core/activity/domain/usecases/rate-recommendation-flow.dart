// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/activity/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/activity-repository.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class RateRecommendationFlow
    implements Usecase<Unit, RateRecommendationFlowParams> {
  final ActivityRepository repository;

  RateRecommendationFlow({
    required this.repository,
  });
  @override
  Future<Either<Failure, Unit>?> call(
      RateRecommendationFlowParams params) async {
    return repository.rateActivity(feedback: params.feedback);
  }
}

class RateRecommendationFlowParams extends Equatable {
  final FeedbackModel feedback;
  const RateRecommendationFlowParams({
    required this.feedback,
  });
  @override
  List<Object> get props {
    return [feedback];
  }
}
