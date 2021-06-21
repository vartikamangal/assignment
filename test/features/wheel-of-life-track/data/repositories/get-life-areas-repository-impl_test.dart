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
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/repository/get-life-areas-repository-impl.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/sources/get-life-areas-remote-data-source.dart';

class MockGetLifeAreasRemoteDataSource extends Mock
    implements GetLifeAreasRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockGetLifeAreasRemoteDataSource remoteDataSource;
  MockNetworkInfo networkInfo;
  GetLifeAreasRepositoryImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteDataSource = MockGetLifeAreasRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    repositoryImpl = GetLifeAreasRepositoryImpl(
      source: remoteDataSource,
      baseRepository: baseRepository,
    );
  });

  const tAreas = [
    LifeAreaModel(
      areaCode: "CAREER",
      description: 'Your job, business and aspirations',
      name: 'Career',
    ),
    LifeAreaModel(
      areaCode: "FINANCES",
      description: 'Your relationship with money',
      name: 'Finances',
    ),
    LifeAreaModel(
      areaCode: "HEALTH",
      description: 'Your body, sickness and wellness',
      name: 'Health',
    ),
    LifeAreaModel(
      areaCode: "FAMILY_AND_FRIENDS",
      description: 'Relationships in your life',
      name: 'Family and Friends',
    ),
    LifeAreaModel(
      areaCode: "ROMANCE",
      description: 'Romance',
      name: 'Romantic love and partnership',
    ),
    LifeAreaModel(
      areaCode: "CAREER",
      description: '',
      name: 'Career',
    ),
    LifeAreaModel(
      areaCode: "PERSONAL_GROWTH",
      description: 'Aims, goals and aspirations',
      name: 'Personal Growth',
    ),
    LifeAreaModel(
      areaCode: "FUN_AND_RECREATION",
      description: 'Entertainment and leisure',
      name: 'Fun and Recreation',
    ),
    LifeAreaModel(
      areaCode: "PHYSICAL_ENVIRONMENT",
      description: 'Your surroundings',
      name: 'Physical Environment',
    ),
  ];

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : GetLifeAreas', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : GetLifeAreas', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  runTestsOnline(() {
    test('should check if the device is online', () async {
      //act
      await repositoryImpl.getLifeAreas();
      //assert
      verify(networkInfo.isConnected);
    });
    test('should return List<LifeAreaModel>', () async {
      //arrange
      when(remoteDataSource.getAreas()).thenAnswer(
        (realInvocation) async => tAreas,
      );
      //act
      final result = await repositoryImpl.getLifeAreas();
      //assert
      verify(remoteDataSource.getAreas());
      expect(result, const Right(tAreas));
    });
    test(
        'should return ServerFailure when call to remote resource is unsuccessfull.',
        () async {
      //arrange
      when(remoteDataSource.getAreas()).thenThrow(ServerException());
      //act
      final result = await repositoryImpl.getLifeAreas();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  runTestsOffline(() {
    test('should return DeviceOfflineFailure', () async {
      //act
      final result = await repositoryImpl.getLifeAreas();
      //assert
      verifyZeroInteractions(remoteDataSource);
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
