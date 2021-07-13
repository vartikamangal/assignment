import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/activity-repository.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/start-activity.dart';
import 'start-activity_test.mocks.dart';

@GenerateMocks([ActivityRepository])
void main() {
  MockActivityRepository? repository;
  late StartActivity useCase;

  setUp(() {
    repository = MockActivityRepository();
    useCase = StartActivity(repository: repository!);
  });

  const tRecommendationId = "";
  const tIsInstantActivity = true;
  const tActivityStatus = ActivityStatus(
      id: 19351,
      journeyId: "1b942ecc-7c76-4237-8f8b-216b9c22e900",
      recommendationId: null,
      actionStatus: "COMPLETED",
      feedbackMood: "NEUTRAL",
      feedbackThoughts: "");

  group('USECASE : startActivity', () {
    test('should start the activity with the help of service', () async {
      //arrange
      when(repository!.startActivity(
              recommendationId: tRecommendationId,
              isInstantActivity: tIsInstantActivity))
          .thenAnswer((_) async => const Right(tActivityStatus));
      //act
      final result = await useCase(const StartAcitvityParams(
          recommendationId: tRecommendationId,
          isInstantActivity: tIsInstantActivity));
      //assert
      verify(repository!.startActivity(
          recommendationId: tRecommendationId,
          isInstantActivity: tIsInstantActivity));
      expect(result, const Right(tActivityStatus));
    });
  });
}
