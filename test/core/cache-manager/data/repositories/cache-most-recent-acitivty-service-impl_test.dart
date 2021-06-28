import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/cache-most-recent-activity-local-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/cache-most-recent-acitivity-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';

class MockCacheMostRecentAcitivityLocalService extends Mock
    implements CacheMostRecentAcitivtyService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockCacheMostRecentAcitivityLocalService service;
  MockNetworkInfo networkInfo;
  CacheMostRecentAcitivityLocalServiceImpl serviceImpl;
  CacheMostRecentAcitivityLocalService localService;
  Box localClient;

  const tActivity =
      CacheAcitivityModel(id: '', title: '', subtitle: '', icon: '');

  const tUnit = unit;

  setUp(() {
    service = MockCacheMostRecentAcitivityLocalService();
    networkInfo = MockNetworkInfo();
    serviceImpl =
        CacheMostRecentAcitivityLocalServiceImpl(localClient: localClient);
  });

  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : cacheActivity', body);
  }

  // runTestOnline(() {
  //   test('should check if the device is online', () async {
  //     //act
  //     await serviceImpl.cacheActivity();
  //     //assert
  //     verify(networkInfo.isConnected);
  //   });
  //   test('should cache most recent acitivty service', () async {
  //     when(service.cacheActivity(acitivity: tActivity))
  //         .thenAnswer((_) async => const Right(tUnit));

  //     final result = await serviceImpl.cacheActivity();
  //     verify(service.cacheActivity(acitivity: tActivity));
  //     expect(result, const Right(tUnit));
  //   });
  //   test(
  //       'should return a ServerFailure when call to remoteDataSource is unsuccessfull.',
  //       () async {
  //     //arrange
  //     when(service.cacheActivity(acitivity: tActivity))
  //         .thenThrow(ServerException());
  //     //act
  //     final result = await serviceImpl.cacheActivity();
  //     //assert
  //     expect(result, Left(ServerFailure()));
  //   });
  // });

  test('DEVICE OFFLINE : fetchActivity should return DeviceOfflineFailure',
      () async {
    when(networkInfo.isConnected).thenAnswer((_) async => false);
    //act
    final result = await service.cacheActivity(acitivity: tActivity);
    //assert
    expect(result, null);
  });
}
