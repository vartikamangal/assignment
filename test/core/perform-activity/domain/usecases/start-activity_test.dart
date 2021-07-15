import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/repositories/activity-repository.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/usecases/start-activity.dart';

import 'start-activity_test.mocks.dart';

@GenerateMocks([ActivityRepository])
void main() {
  late MockActivityRepository repository;
  late StartActivity useCase;

  setUp(() {
    repository = MockActivityRepository();
    useCase = StartActivity(repository: repository);
  });

  final tActivityStatus = ActivityStatus(
      id: 1,
      journeyId: 'journeyId',
      recommendationId: 'recommendationId',
      actionStatus: 'actionStatus',
      feedbackMood: 'feedbackMood',
      feedbackThoughts: 'feedbackThoughts');

  group('USECASE: repository.startActivity()', () {
    test('Should get rateActivity() from the repository', () async {
      when(repository.startActivity(
              recommendationId: 'recommendationId', isInstantActivity: false))
          .thenAnswer((_) async => Right(tActivityStatus));

      final result = await useCase(const StartAcitvityParams(
          recommendationId: 'recommendationId', isInstantActivity: false));

      verify(repository.startActivity(
          recommendationId: 'recommendationId', isInstantActivity: false));
      expect(result, Right(tActivityStatus));
    });
  });
}
