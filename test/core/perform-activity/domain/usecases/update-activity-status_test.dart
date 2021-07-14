import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/repositories/activity-repository.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/usecases/update-activity-status.dart';

import 'update-activity-status_test.mocks.dart';

@GenerateMocks([ActivityRepository])
void main() {
  late MockActivityRepository repository;
  late UpdateActivityStatus useCase;

  setUp(() {
    repository = MockActivityRepository();
    useCase = UpdateActivityStatus(repository: repository);
  });

  const tActivityStatus = ActivityStatus(
      id: 1,
      journeyId: 'journeyId',
      recommendationId: 'recommendationId',
      actionStatus: 'actionStatus',
      feedbackMood: 'feedbackMood',
      feedbackThoughts: 'feedbackThoughts');

  group('USECASE: repository.updateActivityStatus()', () {
    test('Should update activity status in the repository', () async {
      when(repository.updateActivityStatus(status: 'status', actionId: 1))
          .thenAnswer((_) async => const Right(tActivityStatus));

      final result = await useCase(
          const UpdateActivityStatusParams(status: 'status', actionId: 1));

      verify(repository.updateActivityStatus(status: 'status', actionId: 1));
      expect(result, const Right(tActivityStatus));
    });
  });
}
