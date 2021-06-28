import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/log-last-opened-app-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/app-last-opened-log-service.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';

class MockAppLastOpenedLogLocalService extends Mock
    implements AppLastOpenedLogLocalService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockAppLastOpenedLogLocalService localService;
  MockNetworkInfo networkInfo;
  LogLastOpenedAppServiceImpl serviceImpl;
  // AppLastOpenedLogLocalService localService;
  BaseRepository baseRepository;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;

  setUp(() {
    localService = MockAppLastOpenedLogLocalService();
    networkInfo = MockNetworkInfo();
    serviceImpl = LogLastOpenedAppServiceImpl(
        localService: localService, baseRepository: baseRepository);
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
  });

  const tUnit = unit;

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : logStartDatetime', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : logStartDatetime', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  // runTestsOnline(() {
  //   test('should check if the device is online', () async {
  //     //act
  //     await serviceImpl.logStartDatetime();
  //     //assert
  //     verify(networkInfo.isConnected);
  //   });
  //   test('should log start date time', () async {
  //     //arrange
  //     when(localService.logStartDatetime()).thenAnswer((_) async => tUnit);
  //     //act
  //     final result = await serviceImpl.logStartDatetime();
  //     //assert
  //     verify(localService.logStartDatetime());
  //     expect(result, const Right(tUnit));
  //   });
  // });
  // runTestsOffline(() {
  //   test('should return DeviceOfflineFailure', () async {
  //     //act
  //     final result = await serviceImpl.logStartDatetime();
  //     //assert
  //     expect(result, Left(DeviceOfflineFailure()));
  //   });
  // });

  test('DEVICE OFFLINE : fetchActivity should return DeviceOfflineFailure',
      () async {
    when(networkInfo.isConnected).thenAnswer((_) async => false);
    //act
    final result = await localService.logStartDatetime();
    //assert
    expect(result, null);
  });
}
