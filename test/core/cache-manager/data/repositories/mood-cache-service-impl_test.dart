import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cached-mood-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/mood-cache-service-impl.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/mood-cache-local-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';

class MockMoodCacheLocalService extends Mock implements MoodCacheLocalService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockMoodCacheLocalService localService;
  MockNetworkInfo networkInfo;
  MoodCacheServiceImpl serviceImpl;
  BaseRepository baseRepository;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;
  CachedMoodModel cachedMoodModel;

  setUp(() {
    localService = MockMoodCacheLocalService();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
    serviceImpl = MoodCacheServiceImpl(
        localService: localService, baseRepository: baseRepository);
  });

  const tUnit = unit;

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : cached-mood', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : cachedMood', body);
    });
  }

  runTestsOnline(() {
    test('should check if the device is online', () async {
      //act
      await serviceImpl.cacheMood();
      //assert
      verify(networkInfo.isConnected);
    });
    test(
        'should return cached mood when call to remote data source is successfull',
        () async {
      //arrange
      when(localService.cacheMood(cachedMoodModel: cachedMoodModel))
          .thenAnswer((_) async => tUnit);
      //act
      final result =
          await localService.cacheMood(cachedMoodModel: cachedMoodModel);
      //assert
      verify(localService.cacheMood(cachedMoodModel: cachedMoodModel));
      expect(result, tUnit);
    });
    test('should return ServerFailure when the call to remoteService fails',
        () async {
      //arrange
      when(localService.cacheMood(cachedMoodModel: cachedMoodModel))
          .thenThrow(ServerException());
      //act
      final result = await serviceImpl.cacheMood();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  test('DEVICE OFFLINE : caChedMood should return DeviceOfflineFailure',
      () async {
    when(networkInfo.isConnected).thenAnswer((_) async => false);
    //act
    final result =
        await localService.cacheMood(cachedMoodModel: cachedMoodModel);
    //assert
    expect(result, null);
  });
}
