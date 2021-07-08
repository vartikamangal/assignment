import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/user-onboarding-status-local-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'user-onboarding-status-local-service_test.mocks.dart';
import 'package:matcher/matcher.dart';

@GenerateMocks([Box])
void main() {
  late MockBox localClient;
  late UserOnboardingStatusLocalServiceImpl serviceImpl;

  setUp(() {
    localClient = MockBox();
    serviceImpl = UserOnboardingStatusLocalServiceImpl(
      localClient: localClient,
    );
  });

  const tOnBoardingStatus = '';

  group('DATA SOURCE : userOnboardingStatus', () {
    test('should get user onboarding status from the service', () async {
      //arrange
      when(localClient.get(PersistenceConst.USER_ONBOARDING_STATUS))
          .thenAnswer((_) async => tOnBoardingStatus);
      //act
      final result = await serviceImpl.fetchStatus();
      //assert
      verify(localClient.get(PersistenceConst.USER_ONBOARDING_STATUS));
      expect(result, tOnBoardingStatus);
    });

    test('should throw CacheException when fetchStatus is failed', () async {
      //arrange
      when(localClient.get(PersistenceConst.USER_ONBOARDING_STATUS))
          .thenThrow(CacheException());
      //act
      final call = serviceImpl.fetchStatus();
      //assert
      expect(() => call, throwsA(const TypeMatcher<CacheException>()));
    });
  });
}