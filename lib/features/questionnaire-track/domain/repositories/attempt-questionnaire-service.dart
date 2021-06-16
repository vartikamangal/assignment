// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../entities/question-option.dart';
import '../entities/question.dart';
import '../entities/questionnaire.dart';

abstract class AtemptQuestionnaireService {
  Future<Either<Failure, Success>> attempQuestionnaire({
    @required Questionnaire questionnaire,
    @required RxMap<Question, dynamic> questionToAnswerMap,
    @required RxMap<Question, QuestionOption> questionToScaleMap,
  });
}
