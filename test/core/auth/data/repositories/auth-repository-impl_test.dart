// Package Imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
// Project Imports:
import 'package:tatsam_app_experimental/core/auth/data/repositories/auth-repository-impl.dart';
import 'package:tatsam_app_experimental/core/auth/data/sources/auth-remote-service.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';

class MockAuthRemoteService extends Mock implements AuthRemoteService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockNetworkInfo networkInfo;
  MockAuthRemoteService remoteService;
  AuthRepositoryImpl repositoryImpl;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteService = MockAuthRemoteService();
    repositoryImpl = AuthRepositoryImpl(
        remoteService: remoteService, networkInfo: networkInfo);
  });

  const tLoggedIn = false;

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : Auth', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : Auth', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  runTestsOnline(() {
    test('Should check if the device is online', () async {
      await repositoryImpl.checkIfAlreadyLoggedIn();
      verify(networkInfo.isConnected);
    });

    test('should return if already logged in', () async {
      //arrange
      when(remoteService.checkIfAlreadyLoggedIn())
          .thenAnswer((_) async => tLoggedIn);
      //act
      final result = await repositoryImpl.checkIfAlreadyLoggedIn();
      //assert
      verify(remoteService.checkIfAlreadyLoggedIn());
      expect(result, const Right(tLoggedIn));
    });
  });
  runTestsOffline(() {
    test('should return DeviceOfflineFailure', () async {
      //act
      final result = await repositoryImpl.checkIfAlreadyLoggedIn();
      //assert
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
