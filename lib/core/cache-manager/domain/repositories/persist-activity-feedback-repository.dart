// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/activity/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/entities/activity-feedback.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class PersistActivityFeedbackRepository {
  /// Should cache the provided data args, to be treated as recommendation persisted data
  Future<Either<Failure, Unit>> persistFeedback({
    required ActivityStatusModel? activityStatusModel,
    required String textInput,
    required String? voiceNoteInput,
  });

  /// Should provide List of [RecommendationInput] , used in profile diary
  Future<Either<Failure, List<ActivityFeedback>>> getpersistedFeedbacks();
}
