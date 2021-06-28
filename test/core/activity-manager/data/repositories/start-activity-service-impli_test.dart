import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/repositories/start-activity-service-impl.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/sources/start-activity-remote-service.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';

class MockStartActivityRemoteService extends Mock
    implements StartActivityRemoteService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}


void main(){
  StartActivityRemoteService remoteDataService;
  MockNetworkInfo networkInfo;
  StartActivityServiceImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteDataService = MockStartActivityRemoteService();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    repositoryImpl = StartActivityServiceImpl(
      remoteService: remoteDataService,
      baseRepository: baseRepository,
    );
  });

  const tActivityStatus=ActivityStatusModel(id: 19351,
      journeyId: "1b942ecc-7c76-4237-8f8b-216b9c22e900",
      recommendationId: null,
      actionStatus: "COMPLETED",
      feedbackMood: "NEUTRAL",
      feedbackThoughts: "");
  const tRecommendationId="";
  const tisInstantActivity=false;


  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : startActivity', body);
  }

  //! Actual tests go here
  runTestOnline(() {
    test('should check if the device is online', () async {
      //act
      await repositoryImpl.startActivity();
      //assert
      verify(networkInfo.isConnected);
    });
    test(
        'should return a ActivityStatus when call to remote data source is successfull',
            () async {
          //arrange
          when(remoteDataService.startActivity(recommendationId: tRecommendationId, isInstantActivity: tisInstantActivity))
              .thenAnswer((_) async => tActivityStatus);
          //act
          final result = await repositoryImpl.startActivity(recommendationId: tRecommendationId, isInstantActivity: tisInstantActivity);
          //assert
          verify(remoteDataService.startActivity(recommendationId: tRecommendationId, isInstantActivity: tisInstantActivity));
          expect(result, const Right(tActivityStatus));
        });
    test(
        'should return a ServerFailure when call to remoteDataSource is unsuccessfull.',
            () async {
          //arrange
          when(remoteDataService.startActivity(recommendationId: tRecommendationId, isInstantActivity: tisInstantActivity)).thenThrow(ServerException());
          //act
          final result = await repositoryImpl.startActivity(recommendationId: tRecommendationId, isInstantActivity: tisInstantActivity);
          //assert
          expect(result, Left(ServerFailure()));
        });
  });
  test('DEVICE OFFLINE : startActivity should return DeviceOfflineFailure',
          () async {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        //act
        final result = await repositoryImpl.startActivity(recommendationId: tRecommendationId, isInstantActivity: tisInstantActivity);
        //assert
        expect(result, Left(DeviceOfflineFailure()));
      });
}