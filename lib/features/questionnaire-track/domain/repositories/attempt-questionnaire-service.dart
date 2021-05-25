import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-option.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/questionnaire.dart';

abstract class AtemptQuestionnaireService {
  Future<Either<Failure, Success>> attempQuestionnaire({
    @required Questionnaire questionnaire,
    @required RxMap<Question, dynamic> questionToAnswerMap,
    @required RxMap<Question, QuestionOption> questionToScaleMap,
  });
}
