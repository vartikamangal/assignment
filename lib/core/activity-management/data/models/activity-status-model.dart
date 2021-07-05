// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../domain/entities/activity-status.dart';

class ActivityStatusModel extends ActivityStatus {
  const ActivityStatusModel({
    required int? id,
    required String? journeyId,
    required String? recommendationId,
    required String? actionStatus,
    required String? feedbackMood,
    required String? feedbackThoughts,
  }) : super(
          recommendationId: recommendationId,
          actionStatus: actionStatus,
          feedbackMood: feedbackMood,
          feedbackThoughts: feedbackThoughts,
          journeyId: journeyId,
          id: id,
        );

  factory ActivityStatusModel.fromJson(Map<String, dynamic> jsonMap) {
    return ActivityStatusModel(
      id: jsonMap['actionId'] as int?,
      journeyId: jsonMap['journeyId'] as String?,
      recommendationId: jsonMap['recommendationId'] as String?,
      actionStatus: jsonMap['actionStatus'] as String?,
      feedbackMood: jsonMap['feedbackMood'] as String?,
      feedbackThoughts: jsonMap['feedbackThoughts'] as String?,
    );
  }

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
}
