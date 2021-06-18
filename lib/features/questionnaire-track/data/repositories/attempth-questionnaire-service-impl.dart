// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../../../core/success/success-interface.dart';
import '../../domain/entities/question-option.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/questionnaire.dart';
import '../../domain/repositories/attempt-questionnaire-service.dart';
import '../sources/attempt-questionnaire-remote-service.dart';

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
