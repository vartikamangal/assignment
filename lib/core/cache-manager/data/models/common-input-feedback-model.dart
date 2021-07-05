// Flutter imports:

// Project imports:
import '../../../../core/cache-manager/domain/entities/common-input-feedback.dart';

class CommonInputFeedbackModel extends CommonInputFeedback {
  const CommonInputFeedbackModel({
    required String? subjectId,
    required String? activityType,
    required String? textFeedback,
    required String? voiceNote,
    required String? timeOfCreation,
  }) : super(
          voiceNote: voiceNote,
          subjectId: subjectId,
          textFeedback: textFeedback,
          activityType: activityType,
          timeOfCreation: timeOfCreation,
        );

  factory CommonInputFeedbackModel.fromJson(Map<String, dynamic> jsonMap) {
    return CommonInputFeedbackModel(
      subjectId: jsonMap['subjectId'] as String?,
      activityType: jsonMap['activityType'] as String?,
      textFeedback: jsonMap['textFeedback'] as String?,
      voiceNote: jsonMap['voiceNote'] as String?,
      timeOfCreation: jsonMap['timeOfCreation'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "subjectId": subjectId,
      "activityType": activityType,
      "textFeedback": textFeedback,
      "voiceNote": voiceNote,
      "timeOfCreation": timeOfCreation,
    };
  }
}
