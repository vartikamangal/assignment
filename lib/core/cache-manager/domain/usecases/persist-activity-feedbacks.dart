// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/activity/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/persist-activity-feedback-repository.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class PersistActivityFeedback
    implements Usecase<Unit, PersistActivityFeedbackParams> {
  final PersistActivityFeedbackRepository? service;

  PersistActivityFeedback({
    required this.service,
  });
  @override
  Future<Either<Failure, Unit>> call(
      PersistActivityFeedbackParams params) async {
    return service!.persistFeedback(
      activityStatusModel: params.activityStatusModel,
      textInput: params.textInput,
      voiceNoteInput: params.voiceNoteInput,
    );
  }
}

class PersistActivityFeedbackParams extends Equatable {
  final ActivityStatusModel? activityStatusModel;
  final String textInput;
  final String? voiceNoteInput;
  const PersistActivityFeedbackParams({
    required this.activityStatusModel,
    required this.textInput,
    required this.voiceNoteInput,
  });
  @override
  List<Object?> get props => [
        activityStatusModel,
        textInput,
        voiceNoteInput,
      ];
}
