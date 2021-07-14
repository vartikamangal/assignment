// Flutter imports:

// Project imports:
import '../../../image/image.dart';
import '../../domain/entities/activity-step.dart';

class ActivityStepModel extends ActivityStep {
  ActivityStepModel({
    required int? id,
    required String? stepTitle,
    required String? stepHelp,
    required String? stepName,
    required int? stepSequence,
    required ImageModel? iconVO,
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
          iconVO: iconVO?.toDomain(),
        );

  factory ActivityStepModel.fromJson(Map<String, dynamic> jsonMap) {
    return ActivityStepModel(
      id: jsonMap['id'] as int?,
      stepTitle: jsonMap['stepTitle'] as String?,
      stepHelp: jsonMap['stepHelp'] as String?,
      stepName: jsonMap['stepName'] as String?,
      stepSequence: jsonMap['stepSequence'] as int?,
      iconVO: jsonMap['iconVO'] == null
          ? ImageModel.fallbackIcon()
          : ImageModel.fromJson(jsonMap['iconVO'] as Map<String, dynamic>),
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
      "iconVO": ImageModel.fromDomain(iconVO!).toJson(),
      "templateName": templateName,
      "stepContent": stepContent,
    };
  }
}
