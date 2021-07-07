// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/models/emergency-number-model.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/repositories/instant-relief-repository-impl.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/sources/instant-relief-remote-data-source.dart';
import 'list-emergency-numbers-repository-impl_test.mocks.dart';

@GenerateMocks([InstantReliefRemoteDataSource,NetworkInfo])

void main() {
  MockInstantReliefRemoteDataSource? remoteDataSource;
  MockNetworkInfo? networkInfo;
  late InstantReliefRepositoryImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteDataSource = MockInstantReliefRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    repositoryImpl = InstantReliefRepositoryImpl(
      remoteDataSource: remoteDataSource,
      baseRepository: baseRepository,
    );
  });

  const tEmergencyNumbers = <EmergencyNumberModel>[
    EmergencyNumberModel(number: "9545865596")
  ];

  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo!.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : GetEmergencyNumber', body);
  }

  //! Actual tests go here
  runTestOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await repositoryImpl.fetchEmergencyNumbers();
    //   //assert
    //   verify(networkInfo!.isConnected);
    // });
    test(
        'should return a List<EmergencyNumber> when call to remote data source is successfull',
        () async {
      //arrange
      when(remoteDataSource!.fetchEmergencyNumbers())
          .thenAnswer((_) async => tEmergencyNumbers);
      //act
      final result = await repositoryImpl.fetchEmergencyNumbers();
      //assert
      verify(remoteDataSource!.fetchEmergencyNumbers());
      expect(result, const Right(tEmergencyNumbers));
    });
    test(
        'should return a ServerFailure when call to remoteDataSource is unsuccessfull.',
        () async {
      //arrange
      when(remoteDataSource!.fetchEmergencyNumbers())
          .thenThrow(ServerException());
      //act
      final result = await repositoryImpl.fetchEmergencyNumbers();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });

  //! For offline tests
  test('DEVICE OFFLINE : GetAllMoods should return DeviceOfflineFailure',
      () async {
    when(networkInfo!.isConnected).thenAnswer((_) async => false);
    //act
    final result = await repositoryImpl.fetchEmergencyNumbers();
    //assert
    expect(result, Left(DeviceOfflineFailure()));
  });
}
