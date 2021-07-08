import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-option.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/questionnaire.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/repositories/questionnaire-repository.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/usecases/get-questionnaire-by-id.dart';
import 'get-questionnaire-by-id_test.mocks.dart';

@GenerateMocks([QuestionnaireRepository])
void main() {
  late MockQuestionnaireRepository repository;
  late GetQuestionnaireById useCase;

  setUp(() {
    repository = MockQuestionnaireRepository();
    useCase = GetQuestionnaireById(repository: repository);
  });

  const tId = 'id';

  const tTag = [
    Tag(
        name: 'name',
        tagCategory: 'tagCategory',
        displayName: 'displayName',
        parentName: 'parentName')
  ];

  const tQuestion = [
    Question(
        id: 'id',
        questionType: 'questionType',
        status: 'status',
        name: 'name',
        tags: tTag,
        questionOptionVO: <QuestionOption>[],
        questionText: 'questionText',
        questionExplanation: 'questionExplanation',
        creationTime: 'creationTime',
        lastModifiedTime: 'lastModifiedTime',
        questionnaireId: 'questionnaireId')
  ];

  const tQuestionaire = Questionnaire(
      id: '',
      name: 'name',
      title: 'title',
      description: 'description',
      creationDate: '',
      questionVO: tQuestion);
  group('USECASE: getQuestionniare', () {
    test('should get questionnaire by id from the repository ...', () async {
      when(repository.getQuestionniare(id: tId))
          .thenAnswer((_) async => const Right(tQuestionaire));

      final result = await useCase(const GetQuestionnaireByIdParams(id: tId));
      verify(repository.getQuestionniare(id: tId));
      expect(result, const Right(tQuestionaire));
    });
  });
}
