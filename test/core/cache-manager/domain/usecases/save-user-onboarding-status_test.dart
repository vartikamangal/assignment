import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/save-user-onboarding-status-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/save-user-onboarding-status.dart';

class MockSaveUserOnboardingStatusService extends Mock
    implements SaveUserOnboardingStatusService {}

void main() {
  MockSaveUserOnboardingStatusService service;
  SaveUserOnboardingStatus useCase;

  setUp(() {
    service = MockSaveUserOnboardingStatusService();
    useCase = SaveUserOnboardingStatus(service: service);
  });

  const String tStatus = '';
  const tUnit = unit;
  group('USECASE: service.saveStatus()', () {
    test('should save user onboarding status ...', () async {
      when(service.saveStatus(onBoardingStatus: tStatus))
          .thenAnswer((_) async => const Right(tUnit));

      final result =
          await useCase(const SaveUserOnboardingStatusParams(status: tStatus));
      verify(service.saveStatus(onBoardingStatus: tStatus));
      expect(result, const Right(tUnit));
    });
  });
}
