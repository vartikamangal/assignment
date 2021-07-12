// Flutter imports:
// Package imports:
import 'package:equatable/equatable.dart';

class CommonInputFeedback extends Equatable {
  final String? subjectId;
  //[APP_OPEN, RECOMMENDATION, ONBOARDING]
  final String? activityType;
  final String? textFeedback;
  final String? voiceNote;
  final String? timeOfCreation;
  const CommonInputFeedback({
    required this.subjectId,
    required this.activityType,
    required this.textFeedback,
    required this.voiceNote,
    required this.timeOfCreation,
  });
  @override
  List<Object?> get props {
    return [
      subjectId,
      activityType,
      textFeedback,
      voiceNote,
      timeOfCreation,
    ];
  }
}
