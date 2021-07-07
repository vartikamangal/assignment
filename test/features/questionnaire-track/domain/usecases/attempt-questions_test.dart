import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-option.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/questionnaire.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/success-atempt-questionnaire.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/repositories/questionnaire-repository.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/usecases/attempt-questions.dart';
import 'attempt-questions_test.mocks.dart';

@GenerateMocks([QuestionnaireRepository])

void main() {
  late MockQuestionnaireRepository service;
  late AtemptQuestions useCase;

  setUp(() {
    service = MockQuestionnaireRepository();
    useCase = AtemptQuestions(service: service);
  });

  const tTag = [
    Tag(
        name: 'name',
        tagCategory: 'tagCategory',
        displayName: 'displayName',
        parentName: 'parentName')
  ];
  const tQuestionOption = [
    QuestionOption(
        id: 'id',
        optionText: 'optionText',
        optionCategory: 'optionCategory',
        additionalInformation: [])
  ];
  const tQuestion = [
    Question(
        id: 'id',
        questionType: 'questionType',
        status: 'status',
        name: 'name',
        tags: tTag,
        questionOptionVO: tQuestionOption,
        questionText: 'questionText',
        questionExplanation: 'questionExplanation',
        creationTime: 'creationTime',
        lastModifiedTime: 'lastModifiedTime',
        questionnaireId: 'questionnaireId')
  ];
  const tQuestionnair = Questionnaire(
      id: 'id',
      name: 'name',
      title: 'title',
      description: 'description',
      creationDate: 'creationDate',
      questionVO: tQuestion);
  final RxMap<Question, dynamic> questionToAnswerMap = RxMap<Question, dynamic>(
    {},
  );
  final RxMap<Question, QuestionOption> questionToScaleMap =
  RxMap<Question, QuestionOption>(
    {},
  );
  group('USECASE: attempQuestionnaire', () {
    test('should get attempt questions from the service ...', () async {
      when(service.attempQuestionnaire(
          questionnaire: tQuestionnair,
          questionToAnswerMap: questionToAnswerMap,
          questionToScaleMap: questionToScaleMap))
          .thenAnswer((_) async => const Right(SuccessAtemptQuestionnaire()));

      final result = await useCase(AttemptQuestionnaireParams(
          questionToAnswerMap: questionToAnswerMap,
          questionToScaleMap: questionToScaleMap,
          questionnaire: tQuestionnair));

      verify(service.attempQuestionnaire(
          questionnaire: tQuestionnair,
          questionToAnswerMap: questionToAnswerMap,
          questionToScaleMap: questionToScaleMap));

      expect(result, const Right(SuccessAtemptQuestionnaire()));
    });
  });
}