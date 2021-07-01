import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/cache-clearing-service-impl.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/cache-clearing-local-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';

class MockCacheClearingLocalService extends Mock
    implements CacheClearingLocalService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockCacheClearingLocalService localService;
  MockNetworkInfo networkInfo;
  CacheClearingServiceImpl serviceImpl;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;

  setUp(() {
    localService = MockCacheClearingLocalService();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    serviceImpl = CacheClearingServiceImpl(localService: localService);
  });

  const tUnit = unit;
  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : clearDirtyCacheOnFirstRun', body);
  }

  runTestOnline(() {
    test('should check if the device is online', () async {
      //act
      await serviceImpl.clearDirtyCacheOnFirstRun();
      //assert
      verifyNever(networkInfo.isConnected);
    });
    test('should clear dirty cache on first run service', () async {
      //arrange
      when(localService.clearDirtyCacheOnFirstRun())
          .thenAnswer((_) async => tUnit);
      //act
      final result = await serviceImpl.clearDirtyCacheOnFirstRun();
      //assert
      verify(localService.clearDirtyCacheOnFirstRun());
      expect(result, const Right(tUnit));
    });
    test('should return ServerFailure when the call to localService fails',
            () async {
          //arrange
          when(localService.clearDirtyCacheOnFirstRun())
              .thenThrow(CacheException());
          //act
          final result = await serviceImpl.clearDirtyCacheOnFirstRun();
          //assert
          expect(result, Left(CacheFailure()));
        });
  });
  test(
      'DEVICE OFFLINE : clearDirtyCacheOnFirstRun should return DeviceOfflineFailure',
          () async {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        //act
        final result = await localService.clearDirtyCacheOnFirstRun();
        //assert
        expect(result, null);
      });
}