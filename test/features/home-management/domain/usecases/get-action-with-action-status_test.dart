import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/entities/post-onboarding-action.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/repositories/get-action-with-action-status-repository.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/usecases/get-action-with-action-status.dart';
import 'get-action-with-action-status_test.mocks.dart';

@GenerateMocks([GetActionWithActionStatusRepository])

void main() {
  late MockGetActionWithActionStatusRepository repository;
  late GetActionWithActionStatus useCase;

  const tActionStatus = 'status';
  const tPostOnBoardingAction = <PostOnboardingAction>[
    PostOnboardingAction(
        actionId: 1,
        journeyId: 'journeyId',
        actionStatus: 'actionStatus',
        title: 'title',
        subtitle: 'subtitle',
        feedbackMood: 'feedbackMood',
        durationInMinutes: 1)
  ];

  setUp(() {
    repository = MockGetActionWithActionStatusRepository();
    useCase = GetActionWithActionStatus(repository: repository);
  });
  group('USECASE: getAction()', () {
    test('should get action status from the repository ...', () async {
      when(repository.getActions(actionStatus: tActionStatus))
          .thenAnswer((_) async => const Right(tPostOnBoardingAction));

      final result = await useCase(
          const GetActionWithActionStatusParams(actionStatus: tActionStatus));

      verify(repository.getActions(actionStatus: tActionStatus));
      expect(result, const Right(tPostOnBoardingAction));
    });
  });
}
