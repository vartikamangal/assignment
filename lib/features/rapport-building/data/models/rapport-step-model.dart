// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entities/rapport-step.dart';

class RapportStepModel extends RapportStep {
  const RapportStepModel({
    required int? id,
    required String? stepTitle,
    required String? stepContent,
    required String? stepHelp,
    required String? stepDescription,
    required int? stepSequence,
    required ImageProp? icon,
    required String? templateName,
  }) : super(
          stepSequence: stepSequence,
          templateName: templateName,
          stepDescription: stepDescription,
          id: id,
          stepHelp: stepHelp,
          stepContent: stepContent,
          icon: icon,
          stepTitle: stepTitle,
        );

  factory RapportStepModel.fromJson(Map<String, dynamic> jsonMap) {
    return RapportStepModel(
      id: jsonMap['id'] as int?,
      stepTitle: jsonMap['stepTitle'] as String?,
      stepContent: jsonMap['stepContent'] as String?,
      stepHelp: jsonMap['stepHelp'] as String?,
      stepDescription: jsonMap['stepDescription'] as String?,
      stepSequence: jsonMap['stepSequence'] as int?,
      //TODO should be completed once ImageProp is implemented
      icon: null,
      templateName: jsonMap['templateName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "stepTitle": stepTitle,
      "stepContent": stepContent,
      "stepHelp": stepHelp,
      "stepDescription": stepDescription,
      "stepSequence": stepSequence,
      //TODO to be implemented once the image prop is done
      "iconVO": null,
      "templateName": templateName,
    };
  }
}
