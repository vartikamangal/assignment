// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/image/image.dart';

class RecommendationStep extends Equatable {
  final int id;
  final String stepTitle;
  final String stepHelp;
  final String stepName;
  final int stepSequence;
  final ImageProp iconVO;
  final String templateName;
  final String stepContent;
  const RecommendationStep({
    @required this.id,
    @required this.stepTitle,
    @required this.stepHelp,
    @required this.stepName,
    @required this.stepSequence,
    @required this.iconVO,
    @required this.templateName,
    @required this.stepContent,
  });
  @override
  List<Object> get props {
    return [
      id,
      stepTitle,
      stepHelp,
      stepName,
      stepSequence,
      iconVO,
      templateName,
      stepContent,
    ];
  }

  RecommendationStep copyWith({
    int id,
    String stepTitle,
    String stepHelp,
    String stepName,
    int stepSequence,
    ImageProp iconVO,
    String templateName,
    String stepContent,
  }) {
    return RecommendationStep(
      id: id ?? this.id,
      stepTitle: stepTitle ?? this.stepTitle,
      stepHelp: stepHelp ?? this.stepHelp,
      stepName: stepName ?? this.stepName,
      stepSequence: stepSequence ?? this.stepSequence,
      iconVO: iconVO ?? this.iconVO,
      templateName: templateName ?? this.templateName,
      stepContent: stepContent ?? this.stepContent,
    );
  }

  @override
  bool get stringify => true;
}
