import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/activity_rating_model.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/mood-feedback-model-for-activity.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/repositories/activity-repository.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/usecases/rate-activity.dart';

import 'rate-activity_test.mocks.dart';

@GenerateMocks([ActivityRepository])
void main() {
  late MockActivityRepository repository;
  late RateActivity useCase;

  setUp(() {
    repository = MockActivityRepository();
    useCase = RateActivity(repository: repository);
  });

  const tUnit = unit;

  const tMoodFeedbackModelForActivity =
      MoodFeedbackModelForActivity(mood: 'mood', activityType: 'activityType');

  const tFeedback = ActivityRatingModel(
      subjectMoodVO: tMoodFeedbackModelForActivity,
      minutesSpent: 1,
      feedbackThoughts: 'feedbackThoughts',
      recommendationId: 'recommendationId',
      actionId: 1);

  group('USECASE: repository.rateActivity()', () {
    test('Should get rateActivity() from the repository', () async {
      when(repository.rateActivity(feedback: tFeedback))
          .thenAnswer((_) async => const Right(tUnit));

      final result =
          await useCase(const RateActivityParams(feedback: tFeedback));

      verify(repository.rateActivity(feedback: tFeedback));
      expect(result, const Right(tUnit));
    });
  });
}
