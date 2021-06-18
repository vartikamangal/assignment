// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/repositories/persist-recommendation-feedback-service.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class PersistRecommendationFeedback
    implements Usecase<Unit, PersistRecommendationFeedbackParams> {
  final PersistRecommendationFeedbackService service;

  PersistRecommendationFeedback({
    @required this.service,
  });
  @override
  Future<Either<Failure, Unit>> call(
      PersistRecommendationFeedbackParams params) async {
    return service.persistFeedback(
      activityStatusModel: params.activityStatusModel,
      textInput: params.textInput,
      voiceNoteInput: params.voiceNoteInput,
    );
  }
}

class PersistRecommendationFeedbackParams extends Equatable {
  final ActivityStatusModel activityStatusModel;
  final String textInput;
  final String voiceNoteInput;
  const PersistRecommendationFeedbackParams({
    @required this.activityStatusModel,
    @required this.textInput,
    @required this.voiceNoteInput,
  });
  @override
  List<Object> get props => [
        activityStatusModel,
        textInput,
        voiceNoteInput,
      ];
}
