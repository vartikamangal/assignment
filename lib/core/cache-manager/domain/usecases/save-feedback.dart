// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../repositories/save-feedback-service.dart';

/// This usecase is valid for those raw inputs which
/// dont come inside the "OG" PerformActivity Flow
class SaveFeedback implements Usecase<Unit, SaveFeedbackParams> {
  final SaveFeedbackService service;
// Change to fellingDesc
  SaveFeedback({required this.service});
  @override
  Future<Either<Failure, Unit>?> call(SaveFeedbackParams params) async {
    return service.saveFeedback(
      activityType: params.activityType,
      timeOfCreation: params.timeOfCreation,
      textFeedback: params.textFeedback,
      voiceNote: params.voiceNote,
      subjetcId: params.subjetcId,
      boxKey: params.boxKey,
    );
  }
}

class SaveFeedbackParams extends Equatable {
  final String? subjetcId;
  final String activityType;
  final String? textFeedback;
  final String? voiceNote;
  final String timeOfCreation;
  final String boxKey;

  const SaveFeedbackParams({
    required this.subjetcId,
    required this.activityType,
    required this.textFeedback,
    required this.voiceNote,
    required this.timeOfCreation,
    required this.boxKey,
  });
  @override
  List<Object?> get props {
    return [
      subjetcId,
      activityType,
      textFeedback,
      voiceNote,
      timeOfCreation,
      boxKey
    ];
  }
}
