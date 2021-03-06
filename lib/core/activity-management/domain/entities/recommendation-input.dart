// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class RecommendationInput extends Equatable {
  final String recommendationId;
  final String actionId;
  final String journeyId;
  final String textFeedback;
  final String voiceNote;
  final String timeOfCreation;

  const RecommendationInput({
    @required this.recommendationId,
    @required this.actionId,
    @required this.journeyId,
    @required this.textFeedback,
    @required this.voiceNote,
    @required this.timeOfCreation,
  });

  @override
  List<Object> get props {
    return [
      recommendationId,
      actionId,
      journeyId,
      textFeedback,
      voiceNote,
      timeOfCreation,
    ];
  }
}
