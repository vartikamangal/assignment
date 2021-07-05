// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import '../../domain/entities/rapport-building-steps.dart';
import '../../domain/entities/rapport-step.dart';
import 'rapport-step-model.dart';

class RapportBuildingStepsModel extends RapportBuildingSteps {
  const RapportBuildingStepsModel({
    required List<RapportStep> rapportSteps,
  }) : super(
          rapportSteps: rapportSteps,
        );

  factory RapportBuildingStepsModel.fromJson(Map<String, dynamic> jsonMap) {
    final rawRapportSteps = jsonMap['rapportBuildingStepsVO'] as List;
    return RapportBuildingStepsModel(
      rapportSteps: rawRapportSteps
          .map((rawRapportStep) =>
              RapportStepModel.fromJson(rawRapportStep as Map<String, dynamic>))
          .toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return rapportSteps
        .map((rapportStep) => (rapportStep as RapportStepModel).toJson())
        .toList();
  }
}
