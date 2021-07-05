import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/save-is-first-time-onboarding-status.dart';

import 'check-if-first-time-user_test.mocks.dart';

void main() {
  late MockUserOnboardingStatusRepository service;
  late SaveIsFirstTimeOnboardingStatus useCase;

  setUp(() {
    service = MockUserOnboardingStatusRepository();
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
