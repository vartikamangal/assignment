import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'rapport-step.dart';

class RapportBuildingSteps extends Equatable {
  final List<RapportStep> rapportSteps;

  const RapportBuildingSteps({
    @required this.rapportSteps,
  });
  @override
  List<Object> get props => [rapportSteps];

  @override
  bool get stringify => true;
}
