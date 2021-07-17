import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/features/hub/data/repositories/create-traveller-service-impl.dart';
import 'package:tatsam_app_experimental/features/hub/data/sources/create-traveller-remote-service.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/success-create-traveller.dart';
import 'create-traveller-service-impl_test.mocks.dart';

@GenerateMocks([CreateTravellerRemoteService, NetworkInfo])
void main() {
  MockCreateTravellerRemoteService? remoteService;
  MockNetworkInfo? networkInfo;
  late CreateTravellerServiceImpl serviceImpl;
  BaseRepository baseRepository;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;

  setUp(() {
    remoteService = MockCreateTravellerRemoteService();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
    serviceImpl = CreateTravellerServiceImpl(
        remoteService: remoteService, baseRepository: baseRepository);
  });
  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : create-traveller', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : createTraveller', body);
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    test('should check if the device is online', () async {
      //arrange
      when(remoteService!.createTraveller())
          .thenAnswer((_) async => const SuccessCreatedTraveller());
      //act
      await serviceImpl.createTraveller();
      //assert
      verify(networkInfo!.isConnected);
    });
    test(
        'should get basic profile details when coonection to remote data source is successfull',
        () async {
      //arrange
      when(remoteService!.createTraveller())
          .thenAnswer((_) async => const SuccessCreatedTraveller());
      //act
      final result = await remoteService!.createTraveller();
      //assert
      verify(remoteService!.createTraveller());
      expect(result, const SuccessCreatedTraveller());
    });
    test('should return ServerFailure when the call to remoteDataSource fails',
        () async {
      //arrange
      when(remoteService!.createTraveller()).thenThrow(ServerException());
      //act
      final result = await serviceImpl.createTraveller();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
}
