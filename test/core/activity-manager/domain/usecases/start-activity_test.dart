import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/repositories/start-activity-service.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/usecases/start-activity.dart';

class MockStartActivityService extends Mock implements StartActivityService {}

void main(){
  MockStartActivityService service;
  StartActivity useCase;

  setUp(() {
    service = MockStartActivityService();
    useCase = StartActivity(service: service);
  });

  const tRecommendationId="";
  const tIsInstantActivity=true;
  const tActivityStatus=ActivityStatus(id: 19351,
      journeyId: "1b942ecc-7c76-4237-8f8b-216b9c22e900",
      recommendationId: null,
      actionStatus: "COMPLETED",
      feedbackMood: "NEUTRAL",
      feedbackThoughts: "");

  group('USECASE : startActivity', () {
    test('should start the activity with the help of service', () async {
      //arrange
      when(service.startActivity(recommendationId: tRecommendationId, isInstantActivity: tIsInstantActivity))
          .thenAnswer((_) async => const Right(tActivityStatus));
      //act
      final result = await useCase(const StartAcitvityParams(recommendationId: tRecommendationId, isInstantActivity: tIsInstantActivity));
      //assert
      verify(service.startActivity(recommendationId: tRecommendationId, isInstantActivity: tIsInstantActivity));
      expect(result, const Right(tActivityStatus));
    });
  });
}