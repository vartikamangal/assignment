// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/models/instant-relief-area-model.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/repositories/instant-relief-repository-impl.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/sources/instant-relief-remote-data-source.dart';

class MockGetInstantReliefAreaDataSource extends Mock
    implements InstantReliefRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockGetInstantReliefAreaDataSource? remoteDataSource;
  MockNetworkInfo? networkInfo;
  late InstantReliefRepositoryImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteDataSource = MockGetInstantReliefAreaDataSource();
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

  const tInstantReliefAreas = <InstantReliefAreaModel>[
    InstantReliefAreaModel(
        id: 1,
        title: "title",
        subtitle: "subtitle",
        instantReliefName: "instantReliefName",
        description: "description",
        icon: null)
  ];

  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo!.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : GetInstantReliefArea', body);
  }

  //! Actual tests go here
  runTestOnline(() {
    test('should check if the device is online', () async {
      //act
      await repositoryImpl.getReliefAreas();
      //assert
      verify(networkInfo!.isConnected);
    });
    test(
        'should return a List<InstReliefArea> when call to remote data source is successfull',
        () async {
      //arrange
      when(remoteDataSource!.getReliefAreas())
          .thenAnswer((_) async => tInstantReliefAreas);
      //act
      final result = await repositoryImpl.getReliefAreas();
      //assert
      verify(remoteDataSource!.getReliefAreas());
      expect(result, const Right(tInstantReliefAreas));
    });
    test(
        'should return a ServerFailure when call to remoteDataSource is unsuccessfull.',
        () async {
      //arrange
      when(remoteDataSource!.getReliefAreas()).thenThrow(ServerException());
      //act
      final result = await repositoryImpl.getReliefAreas();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  test('DEVICE OFFLINE : GetReliefArea should return DeviceOfflineFailure',
      () async {
    when(networkInfo!.isConnected).thenAnswer((_) async => false);
    //act
    final result = await repositoryImpl.getReliefAreas();
    //assert
    expect(result, Left(DeviceOfflineFailure()));
  });
}
