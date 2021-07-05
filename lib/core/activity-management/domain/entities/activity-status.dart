// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class ActivityStatus extends Equatable {
  final int? id;
  final String? journeyId;
  final String? recommendationId;
  final String? actionStatus;
  final String? feedbackMood;
  final String? feedbackThoughts;
  const ActivityStatus({
    required this.id,
    required this.journeyId,
    required this.recommendationId,
    required this.actionStatus,
    required this.feedbackMood,
    required this.feedbackThoughts,
  });
  @override
  List<Object?> get props {
    return [
      id,
      journeyId,
      recommendationId,
      actionStatus,
      feedbackMood,
      feedbackThoughts,
    ];
  }

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
  bool get stringify => true;
}
