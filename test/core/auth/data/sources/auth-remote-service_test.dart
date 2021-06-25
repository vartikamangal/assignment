import 'package:dartz/dartz.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/auth/data/sources/auth-remote-service.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';

class MockAuthRemoteService extends Mock implements AuthRemoteService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockAuthRemoteService remoteService;
  MockNetworkInfo networkInfo;
  AuthRemoteServiceImpl serviceImpl;
  FlutterSecureStorage secureStorage;
  FlutterAppAuth flutterAppAuth;
  ApiClient apiClient;
  ThrowExceptionIfResponseError throwExceptionIfResponseError;

  setUp(() {
    remoteService = MockAuthRemoteService();
    networkInfo = MockNetworkInfo();
    serviceImpl = AuthRemoteServiceImpl(
        secureStorage: secureStorage,
        flutterAppAuth: flutterAppAuth,
        apiClient: apiClient,
        throwExceptionIfResponseError: throwExceptionIfResponseError);
  });

  const tLoggedIn = false;

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : Auth remote service', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : Auth remote service', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  runTestsOnline(() {
    test('Should check if the device is online', () async {
      await serviceImpl.checkIfAlreadyLoggedIn();
      verify(networkInfo.isConnected);
    });

    test('should return if already logged in', () async {
      //arrange
      when(remoteService.checkIfAlreadyLoggedIn())
          .thenAnswer((_) async => tLoggedIn);
      //act
      final result = await serviceImpl.checkIfAlreadyLoggedIn();
      //assert
      verify(remoteService.checkIfAlreadyLoggedIn());
      expect(result, const Right(tLoggedIn));
    });
  });
  runTestsOffline(() {
    test('should return DeviceOfflineFailure', () async {
      //act
      final result = await serviceImpl.checkIfAlreadyLoggedIn();
      //assert
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
