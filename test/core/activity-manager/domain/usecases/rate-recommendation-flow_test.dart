import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/feedback-mood-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/activity-repository.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/usecases/rate-activity.dart';
import 'start-activity_test.mocks.dart';

@GenerateMocks([ActivityRepository])
void main() {
  MockActivityRepository? repository;
  late RateRecommendationFlow useCase;

  setUp(() {
    repository = MockActivityRepository();
    useCase = RateRecommendationFlow(repository: repository!);
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
      when(repository!.rateActivity(feedback: tFeedbackModel))
          .thenAnswer((_) async => const Right(unit));
      //act
      final result = await useCase(
          const RateRecommendationFlowParams(feedback: tFeedbackModel));
      //assert
      verify(repository!.rateActivity(feedback: tFeedbackModel));
      expect(result, const Right(unit));
    });
  });
}
