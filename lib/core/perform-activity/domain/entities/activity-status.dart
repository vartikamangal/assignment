// Package imports:
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';

class ActivityStatus extends Entity {
  /// This one is action id
  final int? id;
  final String? journeyId;
  final String? recommendationId;
  final String? actionStatus;
  final String? feedbackMood;
  final String? feedbackThoughts;
  ActivityStatus({
    required this.id,
    required this.journeyId,
    required this.recommendationId,
    required this.actionStatus,
    required this.feedbackMood,
    required this.feedbackThoughts,
  });

  ActivityStatus copyWith({
    int? id,
    String? journeyId,
    String? recommendationId,
    String? actionStatus,
    String? feedbackMood,
    String? feedbackThoughts,
  }) {
    return ActivityStatus(
      id: id ?? this.id,
      journeyId: journeyId ?? this.journeyId,
      recommendationId: recommendationId ?? this.recommendationId,
      actionStatus: actionStatus ?? this.actionStatus,
      feedbackMood: feedbackMood ?? this.feedbackMood,
      feedbackThoughts: feedbackThoughts ?? this.feedbackThoughts,
    );
  }

  @override
  String toString() {
    return 'ActivityStatus(id: $id, journeyId: $journeyId, recommendationId: $recommendationId, actionStatus: $actionStatus, feedbackMood: $feedbackMood, feedbackThoughts: $feedbackThoughts)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ActivityStatus &&
        other.id == id &&
        other.journeyId == journeyId &&
        other.recommendationId == recommendationId &&
        other.actionStatus == actionStatus &&
        other.feedbackMood == feedbackMood &&
        other.feedbackThoughts == feedbackThoughts;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        journeyId.hashCode ^
        recommendationId.hashCode ^
        actionStatus.hashCode ^
        feedbackMood.hashCode ^
        feedbackThoughts.hashCode;
  }
}
