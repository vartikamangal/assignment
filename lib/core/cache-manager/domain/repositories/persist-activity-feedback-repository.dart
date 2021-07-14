// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/entities/activity-feedback.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-status.dart';

abstract class PersistActivityFeedbackRepository {
  /// Should cache the provided data args, to be treated as recommendation persisted data
  Future<Either<Failure, Unit>> persistFeedback({
    required ActivityStatus? activityStatus,
    required String textInput,
    required String? voiceNoteInput,
  });

  /// Should provide List of [RecommendationInput] , used in profile diary
  Future<Either<Failure, List<ActivityFeedback>>> getpersistedFeedbacks();
}
