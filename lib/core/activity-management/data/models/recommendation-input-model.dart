// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-input.dart';

class RecommendationInputModel extends RecommendationInput {
  const RecommendationInputModel({
    required String? recommendationId,
    required String? actionId,
    required String? journeyId,
    required String? textFeedback,
    required String? voiceNote,
    required String? timeOfCreation,
  }) : super(
          textFeedback: textFeedback,
          journeyId: journeyId,
          timeOfCreation: timeOfCreation,
          actionId: actionId,
          voiceNote: voiceNote,
          recommendationId: recommendationId,
        );

  factory RecommendationInputModel.fromJson(Map<String, dynamic> jsonMap) {
    return RecommendationInputModel(
      recommendationId: jsonMap['recommendationId'] as String?,
      actionId: jsonMap['actionId'] as String?,
      journeyId: jsonMap['journeyId'] as String?,
      textFeedback: jsonMap['textFeedback'] as String?,
      voiceNote: jsonMap['voiceNote'] as String?,
      timeOfCreation: jsonMap['timeOfCreation'] as String?,
    );
  }

  //! Will help in caching this data to device
  Map<String, dynamic> toJson() {
    return {
      "recommendationId": recommendationId,
      "actionId": actionId,
      "journeyId": journeyId,
      "textFeedback": textFeedback,
      "voiceNote": voiceNote,
      "timeOfCreation": timeOfCreation,
    };
  }
}
