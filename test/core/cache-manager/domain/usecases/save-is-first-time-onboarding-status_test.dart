import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/save-user-onboarding-status-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/save-is-first-time-onboarding-status.dart';

class MockSaveUserOnboardingStatusService extends Mock
    implements SaveUserOnboardingStatusService {}

void main() {
  MockSaveUserOnboardingStatusService service;
  SaveIsFirstTimeOnboardingStatus useCase;

  setUp(() {
    service = MockSaveUserOnboardingStatusService();
    useCase = SaveIsFirstTimeOnboardingStatus(service: service);
  });

  const String tStatus = '';
  const tUnit = unit;
  group('USECASE: service.saveIsFirstTimeOnboardingStatus()', () {
    test('should save is first time onboarding status ...', () async {
      when(service.saveIsFirstTimeOnboardingStatus(onBoardingStatus: tStatus))
          .thenAnswer((_) async => const Right(tUnit));

      final result = await useCase(const SaveIsFirstTimeOnboardingStatusParams(
          onBoardingStatus: tStatus));

      verify(
          service.saveIsFirstTimeOnboardingStatus(onBoardingStatus: tStatus));
      expect(result, const Right(tUnit));
    });
  });
}
