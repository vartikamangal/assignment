// Flutter imports:

// Project imports:
import '../../../image/image.dart';
import '../../domain/entities/activity-step.dart';

class ActivityStepModel extends ActivityStep {
  const ActivityStepModel({
    required int? id,
    required String? stepTitle,
    required String? stepHelp,
    required String? stepName,
    required int? stepSequence,
    required String? iconVO,
    required String? templateName,
    required String? stepContent,
  }) : super(
          templateName: templateName,
          stepContent: stepContent,
          stepHelp: stepHelp,
          stepSequence: stepSequence,
          id: id,
          stepName: stepName,
          stepTitle: stepTitle,
          iconVO: iconVO,
        );

  factory ActivityStepModel.fromJson(Map<String, dynamic> jsonMap) {
    return ActivityStepModel(
      id: jsonMap['id'] as int?,
      stepTitle: jsonMap['stepTitle'] as String?,
      stepHelp: jsonMap['stepHelp'] as String?,
      stepName: jsonMap['stepName'] as String?,
      stepSequence: jsonMap['stepSequence'] as int?,
      iconVO: jsonMap['iconVO'] as String?,
      templateName: jsonMap['templateName'] as String?,
      stepContent: jsonMap['stepContent'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "stepTitle": stepTitle,
      "stepHelp": stepHelp,
      "stepName": stepName,
      "stepSequence": stepSequence,
      "iconVO": iconVO,
      "templateName": templateName,
      "stepContent": stepContent,
    };
  }
}
