import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';

import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/sources/attempt-questionnaire-remote-service.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-option.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/questionnaire.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/repositories/attempt-questionnaire-service.dart';

class AttemptQuestionnaireServiceImpl implements AtemptQuestionnaireService {
  final AttemptQuestionnaireRemoteService remoteService;
  final NetworkInfo networkInfo;

  AttemptQuestionnaireServiceImpl({
    @required this.remoteService,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, Success>> attempQuestionnaire({
    RxMap<Question, dynamic> questionToAnswerMap,
    Questionnaire questionnaire,
    RxMap<Question, QuestionOption> questionToScaleMap,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final attemptResult = await remoteService.attemptQuestionnaire(
          questionToAnswerMap: questionToAnswerMap,
          questionToScaleMap: questionToScaleMap,
          questionnaire: questionnaire,
        );
        return Right(attemptResult);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
