// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class PersistRecommendationFeedbackService {
  Future<Either<Failure, Unit>> persistFeedback({
    @required ActivityStatusModel activityStatusModel,
    @required String textInput,
    @required String voiceNoteInput,
  });
}
