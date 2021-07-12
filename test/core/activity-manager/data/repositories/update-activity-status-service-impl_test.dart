import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/activity-repository-impl.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/sources/activity-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'activity-repository-impl_test.mocks.dart';

@GenerateMocks([AcitivityRemoteDataSource, NetworkInfo])
void main() {
  MockAcitivityRemoteDataSource? remoteDataService;
  MockNetworkInfo? networkInfo;
  late ActivityRepositoryImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteDataService = MockAcitivityRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    repositoryImpl = ActivityRepositoryImpl(
      remoteDataSource: remoteDataService!,
      baseRepository: baseRepository,
    );
  });
  const tStatus = "";
  const tActivityStatus = ActivityStatusModel(
      id: 19351,
      journeyId: "1b942ecc-7c76-4237-8f8b-216b9c22e900",
      recommendationId: null,
      actionStatus: "COMPLETED",
      feedbackMood: "NEUTRAL",
      feedbackThoughts: "");

  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo!.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : updateStatus', body);
  }

  //! Actual tests go here
  runTestOnline(() {
    test('should check if the device is online', () async {
      //arrange
      when(remoteDataService!.updateActivityStatus(status: tStatus,actionId: 1324))
          .thenAnswer((_) async => tActivityStatus);
      //act
      await repositoryImpl.updateActivityStatus(status: tStatus,actionId: 1324);
      //assert
      verify(networkInfo!.isConnected);
    });
    test(
        'should return a activitystatusmodel when call to remote data source is successfull',
        () async {
      //arrange
      when(remoteDataService!
              .updateActivityStatus(status: tStatus, actionId: 1324))
          .thenAnswer((_) async => tActivityStatus);
      //act
      final result = await repositoryImpl.updateActivityStatus(
          status: tStatus, actionId: 1324);
      //assert
      verify(remoteDataService!
          .updateActivityStatus(status: tStatus, actionId: 1324));
      expect(result, const Right(tActivityStatus));
    });
    test(
        'should return a ServerFailure when call to remoteDataSource is unsuccessfull.',
        () async {
      //arrange
      when(remoteDataService!
              .updateActivityStatus(status: tStatus, actionId: 1324))
          .thenThrow(ServerException());
      //act
      final result = await repositoryImpl.updateActivityStatus(
          status: tStatus, actionId: 1324);
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  test('DEVICE OFFLINE : updateStatus should return DeviceOfflineFailure',
      () async {
    when(networkInfo!.isConnected).thenAnswer((_) async => false);
    //act
    final result = await repositoryImpl.updateActivityStatus(
        status: tStatus, actionId: 1324);
    //assert
    expect(result, Left(DeviceOfflineFailure()));
  });
}
