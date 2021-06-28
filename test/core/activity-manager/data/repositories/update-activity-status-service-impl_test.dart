import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/repositories/update-activity-status-service-impl.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/sources/update-activity-status-remote-sevice.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';

class MockUpdateActivityStatusRemoteService extends Mock
    implements UpdateActivityStatusRemoteService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main(){
  UpdateActivityStatusRemoteService remoteDataService;
  MockNetworkInfo networkInfo;
  UpdateActivityStatusServiceImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteDataService = MockUpdateActivityStatusRemoteService();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    repositoryImpl = UpdateActivityStatusServiceImpl(
      remoteService: remoteDataService,
      baseRepository: baseRepository,
    );
  });
  const tStatus="";
  const tActivityStatus=ActivityStatusModel(id: 19351,
      journeyId: "1b942ecc-7c76-4237-8f8b-216b9c22e900",
      recommendationId: null,
      actionStatus: "COMPLETED",
      feedbackMood: "NEUTRAL",
      feedbackThoughts: "");

  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : updateStatus', body);
  }

  //! Actual tests go here
  runTestOnline(() {
    test('should check if the device is online', () async {
      //act
      await repositoryImpl.updateStatus(status: tStatus,actionId: 1324);
      //assert
      verify(networkInfo.isConnected);
    });
    test(
        'should return a activitystatusmodel when call to remote data source is successfull',
            () async {
          //arrange
          when(remoteDataService.modifyStatus(status: tStatus,actionId: 1324))
              .thenAnswer((_) async => tActivityStatus);
          //act
          final result = await repositoryImpl.updateStatus(status: tStatus,actionId: 1324);
          //assert
          verify(remoteDataService.modifyStatus(status: tStatus,actionId: 1324));
          expect(result, const Right(tActivityStatus));
        });
    test(
        'should return a ServerFailure when call to remoteDataSource is unsuccessfull.',
            () async {
          //arrange
          when(remoteDataService.modifyStatus(status: tStatus,actionId: 1324)).thenThrow(ServerException());
          //act
          final result = await repositoryImpl.updateStatus(status: tStatus,actionId: 1324);
          //assert
          expect(result, Left(ServerFailure()));
        });
  });
  test('DEVICE OFFLINE : updateStatus should return DeviceOfflineFailure',
          () async {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        //act
        final result = await repositoryImpl.updateStatus(status: tStatus,actionId: 1324);
        //assert
        expect(result, Left(DeviceOfflineFailure()));
      });
}