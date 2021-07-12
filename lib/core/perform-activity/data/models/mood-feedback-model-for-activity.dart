// Flutter imports:

// Project imports:
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/mood-feedback-for-activity.dart';

class MoodFeedbackModelForActivity extends MoodFeedbackForActivity {
  const MoodFeedbackModelForActivity({
    required String? mood,
    required String? activityType,
  }) : super(
          mood: mood,
          activityType: activityType,
        );

  factory MoodFeedbackModelForActivity.fromJson(Map<String, dynamic> jsonMap) {
    return MoodFeedbackModelForActivity(
      mood: jsonMap['mood'] as String?,
      activityType: jsonMap['activityType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mood": mood,
      "activityType": activityType,
    };
  }
}
