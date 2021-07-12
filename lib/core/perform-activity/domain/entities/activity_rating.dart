// Flutter imports:
// Package imports:
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/mood-feedback-for-activity.dart';

// Project imports:

class ActivityRating extends Equatable {
  final MoodFeedbackForActivity subjectMoodVO;
  final int? minutesSpent;
  final String? feedbackThoughts;
  final String? recommendationId;
  final int? actionId;
  const ActivityRating({
    required this.subjectMoodVO,
    required this.minutesSpent,
    required this.feedbackThoughts,
    required this.recommendationId,
    required this.actionId,
  });
  @override
  List<Object?> get props {
    return [
      subjectMoodVO,
      minutesSpent,
      feedbackThoughts,
      recommendationId,
      actionId,
    ];
  }
}
