import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/save-user-onboarding-status-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/retrieve-user-onboarding-status.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class MockSaveUserOnboardingStatusService extends Mock
    implements SaveUserOnboardingStatusService {}

void main() {
  MockSaveUserOnboardingStatusService service;
  RetrieveUserOnboardingStatus useCase;

  setUp(() {
    service = MockSaveUserOnboardingStatusService();
    useCase = RetrieveUserOnboardingStatus(service: service);
  });

  const String tStatus = '';
  group('USECASE: service.fetchStatus()', () {
    test('should retrieve user onboarding status from the service', () async {
      when(service.fetchStatus()).thenAnswer((_) async => const Right(tStatus));

      final result = await useCase(NoParams());
      verify(service.fetchStatus());
      expect(result, const Right(tStatus));
    });
  });
}
