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
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model-for-prioritization.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/repository/wheel-of-life-repository-impl.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/sources/wheel-of-life-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/success-prioritize.dart';
import 'prioritize-service-impl_test.mocks.dart';

@GenerateMocks([WheelOfLifeRemoteDataSource, NetworkInfo])
void main() {
  late MockWheelOfLifeRemoteDataSource? remoteService;
  MockNetworkInfo? networkInfo;
  late WheelOfLifeRepositoryImpl serviceImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteService = MockWheelOfLifeRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    serviceImpl = WheelOfLifeRepositoryImpl(
      remoteDataSource: remoteService,
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
      description: 'Romantic love and partnership',
      name: 'Romance',
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

  const tLifeAreaPrioritizationModel =
      LifeAreaModelForPrioritization(lifeaAreas: tAreas);

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : PrioritizeService[WOL]', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : PrioritizeService[WOL]', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    test('should check if the device is online', () async {
      //arrange
      when(remoteService!.prioritize(lifeAreas: tLifeAreaPrioritizationModel))
          .thenAnswer((realInvocation) async => SuccessPrioritize());
      //act
      await serviceImpl.prioritize(lifeAreas: tLifeAreaPrioritizationModel);
      //assert
      verify(networkInfo!.isConnected);
    });
    test(
        'should return SuccessPriotize when the call to remote resource is successfull',
        () async {
      //arrange
      when(remoteService!.prioritize(lifeAreas: tLifeAreaPrioritizationModel))
          .thenAnswer((realInvocation) async => SuccessPrioritize());
      //act
      final result =
          await serviceImpl.prioritize(lifeAreas: tLifeAreaPrioritizationModel);
      //assert
      verify(
          remoteService!.prioritize(lifeAreas: tLifeAreaPrioritizationModel));
      expect(result, Right(SuccessPrioritize()));
    });
    test(
        'should return ServerFailure when the call to remote resource is unsuccessfull',
        () async {
      //arrange
      when(remoteService!.prioritize(lifeAreas: tLifeAreaPrioritizationModel))
          .thenThrow(ServerException());
      //act
      final result = await serviceImpl.prioritize(
        lifeAreas: tLifeAreaPrioritizationModel,
      );
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  runTestsOffline(() {
    test('should return DeviceOfflineException ', () async {
      //act
      final result =
          await serviceImpl.prioritize(lifeAreas: tLifeAreaPrioritizationModel);
      //assert
      verifyZeroInteractions(remoteService);
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
