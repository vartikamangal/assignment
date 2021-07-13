import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/entities/activity-feedback.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/persist-activity-feedback-repository.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/get-persisted-feedbacks.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

import 'get-persisted-feedback_test.mocks.dart';

@GenerateMocks([RecommendationFeedbackService])
void main() {
  MockRecommendationFeedbackService? service;
  late GetPersistedFeedbacks useCase;

  setUp(() {
    service = MockRecommendationFeedbackService();
    useCase = GetPersistedFeedbacks(service: service);
  });

  const tRecommendationInput = <RecommendationInput>[
    RecommendationInput(
        recommendationId: null,
        actionId: "19351",
        journeyId: "1b942ecc-7c76-4237-8f8b-216b9c22e900",
        textFeedback: "",
        voiceNote: null,
        timeOfCreation: "2021-06-23 18:40:39.423980"),
    RecommendationInput(
        recommendationId: null,
        actionId: "19359",
        journeyId: "1b942ecc-7c76-4237-8f8b-216b9c22e900",
        textFeedback: "",
        voiceNote: null,
        timeOfCreation: "2021-06-23 18:48:05.414490")
  ];

  group('USECASE : setTarget', () {
    test('should set the user_targets with the help of service', () async {
      //arrange
      when(service!.getpersistedFeedbacks())
          .thenAnswer((_) async => const Right(tRecommendationInput));
      //act
      final Either<Failure, List<RecommendationInput>> result =
          await useCase(NoParams());
      //assert
      verify(service!.getpersistedFeedbacks());
      expect(result, const Right(tRecommendationInput));
    });
  });
}
