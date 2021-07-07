import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/cache-most-recent-acitivty-service-impl.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/cache-most-recent-activity-local-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'cache-most-recent-acitivty-service-impl_test.mocks.dart';

@GenerateMocks([CacheMostRecentAcitivityLocalService,NetworkInfo])

void main() {
  MockCacheMostRecentAcitivityLocalService? localService;
  MockNetworkInfo? networkInfo;
  late CacheMostRecentActivityServiceImpl serviceImpl;
  BaseRepository baseRepository;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;
  CacheAcitivityModel? cacheActivityModel;

  setUp(() {
    localService = MockCacheMostRecentAcitivityLocalService();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
    serviceImpl = CacheMostRecentActivityServiceImpl(
        localService: localService, baseRepository: baseRepository);
  });

  const tcacheActivityModel = CacheAcitivityModel(
      id: 'id', title: 'title', subtitle: 'subtitle', icon: 'icon');

  const tUnit = unit;

  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo!.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : cacheActivity', body);
  }

  runTestOnline(() {
    test('should check if the device is online', () async {
      //act
      await serviceImpl.cacheActivity(acitivity: tcacheActivityModel);
      //assert
      verify(networkInfo!.isConnected);
    });
    test('should cache most recent acitivty service', () async {
      when(localService!.cacheActivity(acitivity: cacheActivityModel))
          .thenAnswer((_) async => tUnit);

      final result = await serviceImpl.cacheActivity(acitivity: tcacheActivityModel);
      verify(localService!.cacheActivity(acitivity: cacheActivityModel));
      expect(result, const Right(tUnit));
    });
    test(
        'should return a ServerFailure when call to local service is unsuccessfull.',
            () async {
          //arrange
          when(localService!.cacheActivity(acitivity: cacheActivityModel))
              .thenThrow(ServerException());
          //act
          final result = await serviceImpl.cacheActivity(acitivity: tcacheActivityModel);
          //assert
          expect(result, Left(ServerFailure()));
        });
  });

  test('DEVICE OFFLINE : fetchActivity should return DeviceOfflineFailure',
          () async {
        when(networkInfo!.isConnected).thenAnswer((_) async => false);
        //act
        final result =
        await localService!.cacheActivity(acitivity: cacheActivityModel);
        //assert
        expect(result, null);
      });
}