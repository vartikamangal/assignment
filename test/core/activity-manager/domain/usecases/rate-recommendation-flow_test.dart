import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-mood-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/repositories/rate-recommendation-flow-service.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/usecases/rate-recommendation-flow.dart';

import 'rate-recommendation-flow_test.mocks.dart';

@GenerateMocks([RateRecommendationFlowService])
void main() {
  MockRateRecommendationFlowService? service;
  late RateRecommendationFlow useCase;

  setUp(() {
    service = MockRateRecommendationFlowService();
    useCase = RateRecommendationFlow(service: service);
  });

  const tFeedbackModel = FeedbackModel(
      subjectMoodVO:
          FeedbackMoodModel(mood: "GOOD", activityType: "RECOMMENDATION"),
      minutesSpent: 4,
      feedbackThoughts: "",
      recommendationId: null,
      actionId: 19389);

  group('USECASE : rateRecommendation', () {
    test('should rate the recommendationFlow with the help of service',
        () async {
      //arrange
      when(service!.rateRecommendation(feedback: tFeedbackModel))
          .thenAnswer((_) async => const Right(unit));
      //act
      final result = await useCase(
          const RateRecommendationFlowParams(feedback: tFeedbackModel));
      //assert
      verify(service!.rateRecommendation(feedback: tFeedbackModel));
      expect(result, const Right(unit));
    });
  });
}
