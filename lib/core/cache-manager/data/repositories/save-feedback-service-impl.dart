// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/cache-manager/data/services/save-feedback-local-service.dart';
import '../../../../core/cache-manager/domain/repositories/save-feedback-service.dart';
import '../../../error/exceptions.dart';
import '../../../error/failures.dart';

class SaveFeedbackServiceImpl implements SaveFeedbackService {
  final SaveFeedbackLocalService localService;

  const SaveFeedbackServiceImpl({@required this.localService});

  @override
  Future<Either<Failure, Unit>> saveFeedback({
    String subjetcId,
    String activityType,
    String textFeedback,
    String voiceNote,
    String timeOfCreation,
    String boxKey,
  }) async {
    try {
      final setFeelingStatus = await localService.setFeeling(
        timeOfCreation: timeOfCreation,
        activityType: activityType,
        voiceNote: voiceNote,
        subjetcId: subjetcId,
        textFeedback: textFeedback,
        boxKey: boxKey,
      );
      return Right(setFeelingStatus);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
