import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/persist-recommendation-feedback-service.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/persist-recommendation-feedback.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

import 'get-persisted-feedback_test.mocks.dart';

@GenerateMocks([RecommendationFeedbackService])
void main() {
  late MockRecommendationFeedbackService? service;
  late PersistRecommendationFeedback useCase;

  setUp(() {
    service = MockRecommendationFeedbackService();
    useCase = PersistRecommendationFeedback(service: service);
  });

  const tActivityStatusModel = ActivityStatusModel(
      id: 19351,
      journeyId: "1b942ecc-7c76-4237-8f8b-216b9c22e900",
      recommendationId: null,
      actionStatus: "COMPLETED",
      feedbackMood: "NEUTRAL",
      feedbackThoughts: "");
  const tTextInput = "";
  const tVoiceNoteInput = "";
  group('USECASE : PersistRecommendationFeedback', () {
    test('should persist the recommendation-feedback with the help of service',
        () async {
      //arrange
      when(service!.persistFeedback(
              activityStatusModel: tActivityStatusModel,
              textInput: tTextInput,
              voiceNoteInput: tVoiceNoteInput))
          .thenAnswer((_) async => const Right(unit));
      //act
      final Either<Failure, Unit> result = await useCase(
          const PersistRecommendationFeedbackParams(
              activityStatusModel: tActivityStatusModel,
              textInput: tTextInput,
              voiceNoteInput: tVoiceNoteInput));
      //assert
      verify(service!.persistFeedback(
          activityStatusModel: tActivityStatusModel,
          textInput: tTextInput,
          voiceNoteInput: tVoiceNoteInput));
      expect(result, const Right(unit));
    });
  });
}
