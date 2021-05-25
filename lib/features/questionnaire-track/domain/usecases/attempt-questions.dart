import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-option.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/questionnaire.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/repositories/attempt-questionnaire-service.dart';

class AtemptQuestions implements Usecase<Success, AttemptQuestionnaireParams> {
  final AtemptQuestionnaireService service;

  AtemptQuestions({
    @required this.service,
  });
  @override
  Future<Either<Failure, Success>> call(
    AttemptQuestionnaireParams params,
  ) async {
    return service.attempQuestionnaire(
      questionToAnswerMap: params.questionToAnswerMap,
      questionToScaleMap: params.questionToScaleMap,
      questionnaire: params.questionnaire,
    );
  }
}

class AttemptQuestionnaireParams extends Equatable {
  final Questionnaire questionnaire;
  final RxMap<Question, dynamic> questionToAnswerMap;
  final RxMap<Question, QuestionOption> questionToScaleMap;

  const AttemptQuestionnaireParams({
    @required this.questionToAnswerMap,
    @required this.questionToScaleMap,
    @required this.questionnaire,
  });

  @override
  List<Object> get props => [
        questionnaire,
        questionToAnswerMap,
        questionToScaleMap,
      ];
}
