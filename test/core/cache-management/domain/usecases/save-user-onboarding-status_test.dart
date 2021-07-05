import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/user-onboarding-status-repository.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/save-user-onboarding-status.dart';

import 'check-if-first-time-user_test.mocks.dart';

@GenerateMocks([UserOnboardingStatusRepository])
void main() {
  late MockUserOnboardingStatusRepository service;
  late SaveUserOnboardingStatus useCase;

  setUp(() {
    service = MockUserOnboardingStatusRepository();
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
