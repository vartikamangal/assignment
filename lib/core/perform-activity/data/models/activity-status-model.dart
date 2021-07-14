import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';

import '../../../perform-activity/domain/entities/activity-status.dart';

class ActivityStatusModel extends DataModel<ActivityStatus> {
  int? id;
  String? journeyId;
  String? recommendationId;
  String? actionStatus;
  String? feedbackMood;
  String? feedbackThoughts;

  ActivityStatusModel.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['actionId'] as int?,
        journeyId = jsonMap['journeyId'] as String?,
        recommendationId = jsonMap['recommendationId'] as String?,
        actionStatus = jsonMap['actionStatus'] as String?,
        feedbackMood = jsonMap['feedbackMood'] as String?,
        feedbackThoughts = jsonMap['feedbackThoughts'] as String?;

  ActivityStatusModel.fromDomain(ActivityStatus activityStatus)
      : id = activityStatus.id,
        journeyId = activityStatus.journeyId,
        recommendationId = activityStatus.recommendationId,
        actionStatus = activityStatus.actionStatus,
        feedbackMood = activityStatus.feedbackMood,
        feedbackThoughts = activityStatus.feedbackThoughts;

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "journeyId": journeyId,
      "recommendationId": recommendationId,
      "actionStatus": actionStatus,
      "feedbackMood": feedbackMood,
      "feedbackThoughts": feedbackThoughts,
    };
  }

  @override
  ActivityStatus toDomain() {
    return ActivityStatus(
      id: id,
      journeyId: journeyId,
      recommendationId: recommendationId,
      actionStatus: actionStatus,
      feedbackMood: feedbackMood,
      feedbackThoughts: feedbackThoughts,
    );
  }
}
