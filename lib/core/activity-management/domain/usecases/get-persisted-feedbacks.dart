import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-input.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/repositories/persist-recommendation-feedback-service.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class GetPersistedFeedbacks
    implements Usecase<List<RecommendationInput>, NoParams> {
  final RecommendationFeedbackService service;

  GetPersistedFeedbacks({
    @required this.service,
  });
  @override
  Future<Either<Failure, List<RecommendationInput>>> call(
      NoParams params) async {
    return service.getpersistedFeedbacks();
  }
}
