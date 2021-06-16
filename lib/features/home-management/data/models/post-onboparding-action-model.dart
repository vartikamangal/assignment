import 'package:flutter/foundation.dart';
import '../../domain/entities/post-onboarding-action.dart';

class PostOnboardingActionModel extends PostOnboardingAction {
  const PostOnboardingActionModel({
    @required int actionId,
    @required String journeyId,
    @required String actionStatus,
    @required String title,
    @required String subtitle,
    @required String feedbackMood,
    @required int durationInMinutes,
  }) : super(
          actionId: actionId,
          actionStatus: actionStatus,
          journeyId: journeyId,
          title: title,
          subtitle: subtitle,
          durationInMinutes: durationInMinutes,
          feedbackMood: feedbackMood,
        );

  factory PostOnboardingActionModel.fromJson(Map<String, dynamic> jsonMap) {
    return PostOnboardingActionModel(
      actionId: jsonMap['actionId'] as int,
      journeyId: jsonMap['journeyId'] as String,
      feedbackMood: jsonMap['feedbackMood'] as String,
      actionStatus: jsonMap['actionStatus'] as String,
      title: jsonMap['recommendationVO']['title'] as String,
      subtitle: jsonMap['recommendationVO']['subtitle'] as String,
      durationInMinutes:
          jsonMap['recommendationVO']['durationInMinutes'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'actionId': actionId,
      'journeyId': journeyId,
      'actionStatus': actionStatus,
      'title': title,
      'feedbackMood': feedbackMood,
      'subtitle': subtitle,
      'durationInMinutes': durationInMinutes,
    };
  }
}
