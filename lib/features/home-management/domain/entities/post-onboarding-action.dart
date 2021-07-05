import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PostOnboardingAction extends Equatable {
  final int? actionId;
  final String? journeyId;
  final String? actionStatus;
  final String? title;
  final String? subtitle;
  final String? feedbackMood;
  final int? durationInMinutes;

  const PostOnboardingAction({
    required this.actionId,
    required this.journeyId,
    required this.actionStatus,
    required this.title,
    required this.subtitle,
    required this.feedbackMood,
    required this.durationInMinutes,
  });

  @override
  List<Object?> get props {
    return [
      actionId,
      journeyId,
      actionStatus,
      title,
      subtitle,
      durationInMinutes,
      feedbackMood,
    ];
  }
}
