// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../error/failures.dart';

abstract class SaveFeedbackService {
  Future<Either<Failure, Unit>> saveFeedback({
    @required String subjetcId,
    @required String activityType,
    @required String textFeedback,
    @required String voiceNote,
    @required String timeOfCreation,

    /// where to put the persisted value
    @required String boxKey,
  });
}
