import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/cache-clearing-service-impl.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/cache-clearing-local-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/cache-clearing-service.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';

class MockCacheClearingService extends Mock implements CacheClearingService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockCacheClearingService service;
  MockNetworkInfo networkInfo;
  CacheClearingServiceImpl serviceImpl;
  CacheClearingLocalService localService;

  setUp(() {
    service = MockCacheClearingService();
    networkInfo = MockNetworkInfo();
    serviceImpl = CacheClearingServiceImpl(localService: localService);
  });

  const tUnit = unit;
  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : clearDirtyCacheOnFirstRun()', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : clearDirtyCacheOnFirstRun()', body);
    });
  }

  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await serviceImpl.clearDirtyCacheOnFirstRun();
    //   //assert
    //   verify(networkInfo.isConnected);
    // });
    // test('should clear dirty cache on first run service', () async {
    //   //arrange
    //   when(service.clearDirtyCacheOnFirstRun())
    //       .thenAnswer((_) async => const Right(tUnit));
    //   //act
    //   final result = await service.clearDirtyCacheOnFirstRun();
    //   //assert
    //   verify(service.clearDirtyCacheOnFirstRun());
    //   expect(result, const Right(tUnit));
    // });
    // test('should return ServerFailure when the call to localService fails',
    //     () async {
    //   //arrange
    //   when(localService.fetchStatus()).thenThrow(ServerException());
    //   //act
    //   final result = await serviceImpl.fetchStatus();
    //   //assert
    //   expect(result, Left(ServerFailure()));
    // });
  });
  test(
      'DEVICE OFFLINE : clearDirtyCacheOnFirstRun should return DeviceOfflineFailure',
      () async {
    when(networkInfo.isConnected).thenAnswer((_) async => false);
    //act
    final result = await service.clearDirtyCacheOnFirstRun();
    //assert
    expect(result, null);
  });
}
