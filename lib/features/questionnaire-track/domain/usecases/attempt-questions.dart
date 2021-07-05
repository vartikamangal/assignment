// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/repositories/questionnaire-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/question-option.dart';
import '../entities/question.dart';
import '../entities/questionnaire.dart';

class AtemptQuestions implements Usecase<Success, AttemptQuestionnaireParams> {
  final QuestionnaireRepository service;

  AtemptQuestions({
    required this.service,
  });
  @override
  Future<Either<Failure, Success>?> call(
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
  final Questionnaire? questionnaire;
  final RxMap<Question, dynamic> questionToAnswerMap;
  final RxMap<Question, QuestionOption> questionToScaleMap;

  const AttemptQuestionnaireParams({
    required this.questionToAnswerMap,
    required this.questionToScaleMap,
    required this.questionnaire,
  });

  @override
  List<Object?> get props => [
        questionnaire,
        questionToAnswerMap,
        questionToScaleMap,
      ];
}
