// Flutter imports:

// Project imports:
import 'package:tatsam_app_experimental/core/activity/domain/entities/feedback.dart';

import 'feedback-mood-model.dart';

class FeedbackModel extends Feedback {
  const FeedbackModel({
    required FeedbackMoodModel subjectMoodVO,
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

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      subjectMoodVO: FeedbackMoodModel.fromJson(
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
      "subjectMoodVO": subjectMoodVO.toJson(),
      "minutesSpent": minutesSpent,
      "feedbackThoughts": feedbackThoughts,
      "recommendationId": recommendationId,
      "actionId": actionId,
    };
  }
}
