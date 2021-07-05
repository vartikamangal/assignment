import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/log-last-opened-app-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/app-last-opened-log-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';

import '../../../core_mock_generator_test.mocks.dart';
import 'log-last-opened-app-service_test.mocks.dart';

@GenerateMocks([AppLastOpenedLogLocalService])
void main() {
  late MockAppLastOpenedLogLocalService localService;
  late MockNetworkInfo networkInfo;
  late LogLastOpenedAppServiceImpl serviceImpl;
  BaseRepository baseRepository;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;

  setUp(() {
    localService = MockAppLastOpenedLogLocalService();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
    serviceImpl = LogLastOpenedAppServiceImpl(
        localService: localService, baseRepository: baseRepository);
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

  runTestsOnline(() {
    test('should check if the device is online', () async {
      //act
      await serviceImpl.logStartDatetime();
      //assert
      verify(networkInfo.isConnected);
    });
    test('should log start date time', () async {
      //arrange
      when(localService.logStartDatetime()).thenAnswer((_) async => tUnit);
      //act
      final result = await serviceImpl.logStartDatetime();
      //assert
      verify(localService.logStartDatetime());
      expect(result, const Right(tUnit));
    });
    test('should return ServerFailure when the call to localService fails',
        () async {
      //arrange
      when(localService.logStartDatetime()).thenThrow(ServerException());
      //act
      final result = await serviceImpl.logStartDatetime();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  runTestsOffline(() {
    test('should return DeviceOfflineFailure', () async {
      //act
      final result = await serviceImpl.logStartDatetime();
      //assert
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
