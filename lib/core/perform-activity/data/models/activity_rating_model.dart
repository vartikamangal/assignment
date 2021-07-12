// Flutter imports:

// Project imports:
import 'package:tatsam_app_experimental/core/perform-activity/data/models/mood-feedback-model-for-activity.dart';

import '../../domain/entities/activity_rating.dart';

class ActivityRatingModel extends ActivityRating {
  const ActivityRatingModel({
    required MoodFeedbackModelForActivity subjectMoodVO,
    required int? minutesSpent,
    required String? feedbackThoughts,
    required String? recommendationId,
    required int? actionId,
  }) : super(
          subjectMoodVO: subjectMoodVO,
          minutesSpent: minutesSpent,
          recommendationId: recommendationId,
          feedbackThoughts: feedbackThoughts,
          actionId: actionId,
        );

  factory ActivityRatingModel.fromMap(Map<String, dynamic> map) {
    return ActivityRatingModel(
      subjectMoodVO: MoodFeedbackModelForActivity.fromJson(
        map['subjectMoodVO'] as Map<String, dynamic>,
      ),
      minutesSpent: map['minutesSpent'] as int?,
      feedbackThoughts: map['feedbackThoughts'] as String?,
      recommendationId: map['recommendationId'] as String?,
      actionId: map['actionId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "subjectMoodVO": (subjectMoodVO as MoodFeedbackModelForActivity).toJson(),
      "minutesSpent": minutesSpent,
      "feedbackThoughts": feedbackThoughts,
      "recommendationId": recommendationId,
      "actionId": actionId,
    };
  }
}
