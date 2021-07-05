import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/save-user-onboarding-status-service-impl.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/user-onboarding-status-local-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';

import '../../../core_mock_generator_test.mocks.dart';
import 'save-user-onboarding-status-service-impl_test.mocks.dart';

@GenerateMocks([UserOnboardingStatusLocalService])
void main() {
  late MockUserOnboardingStatusLocalService localService;
  late MockNetworkInfo networkInfo;
  late SaveUserOnboardingStatusServiceImpl serviceImpl;
  late BaseRepository baseRepository;
  late CallIfNetworkConnected callIfNetworkConnected;
  late HandleException handleException;

  setUp(() {
    localService = MockUserOnboardingStatusLocalService();
    networkInfo = MockNetworkInfo();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    serviceImpl = SaveUserOnboardingStatusServiceImpl(
        localService: localService, baseRepository: baseRepository);
  });

  const tStatus = 'fetch status';

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : fetchStatus()', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : fetchStatus()', body);
    });
  }

  runTestsOnline(() {
    test('should check if the device is online', () async {
      //act
      await localService.fetchStatus();
      //assert
      verifyNever(networkInfo.isConnected);
    });
    test('should fetch user onboarding status', () async {
      //arrange
      when(localService.fetchStatus()).thenAnswer((_) async => tStatus);
      //act
      final result = await localService.fetchStatus();
      //assert
      verify(localService.fetchStatus());
      expect(result, tStatus);
    });
    test('should return ServerFailure when the call to localService fails',
        () async {
      //arrange
      when(localService.fetchStatus()).thenThrow(ServerException());
      //act
      final result = await serviceImpl.fetchStatus();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  test('DEVICE OFFLINE : fetchActivity should return DeviceOfflineFailure',
      () async {
    when(networkInfo.isConnected).thenAnswer((_) async => false);
    //act
    final result = await localService.fetchStatus();
    //assert
    expect(result, null);
  });
}
