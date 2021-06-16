// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/feedback-mood.dart';

class FeedbackMoodModel extends FeedbackMood {
  const FeedbackMoodModel({
    @required String mood,
    @required String activityType,
  }) : super(
          mood: mood,
          activityType: activityType,
        );

  factory FeedbackMoodModel.fromJson(Map<String, dynamic> jsonMap) {
    return FeedbackMoodModel(
      mood: jsonMap['mood'] as String,
      activityType: jsonMap['activityType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mood": mood,
      "activityType": activityType,
    };
  }
}
