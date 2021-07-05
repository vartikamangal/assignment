import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/user-onboarding-status-repository.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/check-if-first-time-user.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

import 'check-if-first-time-user_test.mocks.dart';

@GenerateMocks([UserOnboardingStatusRepository])
void main() {
  late MockUserOnboardingStatusRepository service;
  late CheckIfFirstTimeUser useCase;

  setUp(() {
    service = MockUserOnboardingStatusRepository();
    useCase = CheckIfFirstTimeUser(service: service);
  });

  const bool tIsFirstTime = false;
  group('USECASE: service.checkIfFirstTimeUser()', () {
    test('Should check if user is first timer', () async {
      when(service.checkIfFirstTimeUser())
          .thenAnswer((_) async => const Right(tIsFirstTime));

      final result = await useCase(NoParams());
      verify(service.checkIfFirstTimeUser());
      expect(result, const Right(tIsFirstTime));
    });
  });
}
