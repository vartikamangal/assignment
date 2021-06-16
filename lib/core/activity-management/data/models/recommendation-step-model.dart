// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entities/recommendation-step.dart';

class RecommendationStepModel extends RecommendationStep {
  const RecommendationStepModel({
    @required int id,
    @required String stepTitle,
    @required String stepHelp,
    @required String stepName,
    @required int stepSequence,
    @required ImageProp iconVO,
    @required String templateName,
    @required String stepContent,
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

  factory RecommendationStepModel.fromJson(Map<String, dynamic> jsonMap) {
    return RecommendationStepModel(
      id: jsonMap['id'] as int,
      stepTitle: jsonMap['stepTitle'] as String,
      stepHelp: jsonMap['stepHelp'] as String,
      stepName: jsonMap['stepName'] as String,
      stepSequence: jsonMap['stepSequence'] as int,
      iconVO: const ImageProp(),
      templateName: jsonMap['templateName'] as String,
      stepContent: jsonMap['stepContent'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "stepTitle": stepTitle,
      "stepHelp": stepHelp,
      "stepName": stepName,
      "stepSequence": stepSequence,
      "iconVO": null,
      "templateName": templateName,
      "stepContent": stepContent,
    };
  }
}
