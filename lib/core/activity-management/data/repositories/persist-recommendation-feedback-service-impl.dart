// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/sources/persist-recommendation-input-local-service.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/repositories/persist-recommendation-feedback-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

class PersistRecommendationFeedbackServiceImpl
    implements PersistRecommendationFeedbackService {
  final PersistRecommendationFeedbackLocalService localService;

  PersistRecommendationFeedbackServiceImpl({
    @required this.localService,
  });
  @override
  Future<Either<Failure, Unit>> persistFeedback({
    ActivityStatusModel activityStatusModel,
    String textInput,
    String voiceNoteInput,
  }) async {
    try {
      final status = await localService.persistFeedback(
        activityStatusModel: activityStatusModel,
        textInput: textInput,
        voiceNoteInput: voiceNoteInput,
      );
      return Right(status);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
