// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class FeedbackMood extends Equatable {
  final String mood;
  final String activityType;
  const FeedbackMood({
    @required this.mood,
    @required this.activityType,
  });
  @override
  List<Object> get props => [mood, activityType];
}
