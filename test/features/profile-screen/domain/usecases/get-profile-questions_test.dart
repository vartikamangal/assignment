// Package Imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
// Project Imports:
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/profile-question.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/question-info.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/question-log.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/repositories/profile-details-repository.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/usecases/get-profile-questions.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-option.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/rating-scale.dart';

class MockProfileDetailsRepository extends Mock
    implements ProfileDetailsRepository {}

void main() {
  MockProfileDetailsRepository repository;
  GetProfileQuestions useCase;

  setUp(() {
    repository = MockProfileDetailsRepository();
    useCase = GetProfileQuestions(repository: repository);
  });

  final tQuestionLog = [
    QuestionLog(
        id: 0,
        answeredWhen: DateTime.now(),
        question: ProfileQuestion(
            id: '',
            questionType: '',
            status: '',
            creationTime: DateTime.now(),
            lastModifiedTime: DateTime.now(),
            name: '',
            tags: const [
              Tag(name: '', tagCategory: '', displayName: '', parentName: '')
            ],
            questionOptions: [
              QuestionOption(
                  id: '',
                  optionText: '',
                  optionCategory: '',
                  additionalInformation: [
                    RatingScale(
                        min: 0, max: 0, ratingValue: 0, ratingScaleName: '')
                  ])
            ],
            questionInformation: const QuestionInfo(
                id: 0, questionText: '', questionExplanation: '')),
        optionChosen: [
          QuestionOption(
              id: '',
              optionText: '',
              optionCategory: '',
              additionalInformation: [
                RatingScale(min: 0, max: 0, ratingValue: 0, ratingScaleName: '')
              ])
        ],
        additionalInformation: '')
  ];

  group("USECASE : getProfileQuestions()", () {
    test('should get all the profile question logs from the repository',
        () async {
      //arrange
      when(repository.getProfileQuestions())
          .thenAnswer((_) async => Right(tQuestionLog));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getProfileQuestions());
      expect(result, Right(tQuestionLog));
    });
  });
}
