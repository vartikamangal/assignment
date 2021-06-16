// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-mood-model.dart';

class Feedback extends Equatable {
  final FeedbackMoodModel subjectMoodVO;
  final int minutesSpent;
  final String feedbackThoughts;
  final String recommendationId;
  final int actionId;
  const Feedback({
    @required this.subjectMoodVO,
    @required this.minutesSpent,
    @required this.feedbackThoughts,
    @required this.recommendationId,
    @required this.actionId,
  });
  @override
  List<Object> get props {
    return [
      subjectMoodVO,
      minutesSpent,
      feedbackThoughts,
      recommendationId,
      actionId,
    ];
  }
}
