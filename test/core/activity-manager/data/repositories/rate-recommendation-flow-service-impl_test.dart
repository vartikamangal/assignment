import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-mood-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/repositories/rate-recommendation-flow-service-impl.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/sources/rate-recommendation-flow-remote-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';

class MockRateRecommendationFlowRemoteService extends Mock
    implements RateRecommendationFlowRemoteService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main(){
  RateRecommendationFlowRemoteService? remoteDataService;
  MockNetworkInfo? networkInfo;
  late RateRecommendationFlowServiceImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteDataService = MockRateRecommendationFlowRemoteService();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    repositoryImpl = RateRecommendationFlowServiceImpl(
      remoteService: remoteDataService,
      baseRepository: baseRepository,
    );
  });

  const tFeedbackModel=FeedbackModel( subjectMoodVO: FeedbackMoodModel(mood: "GOOD",
      activityType: "RECOMMENDATION"),
      minutesSpent: 4,
      feedbackThoughts: "",
      recommendationId: null,
      actionId: 19389);

  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo!.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : rateRecommendationFlow', body);
  }

  //! Actual tests go here
  runTestOnline(() {
    test('should check if the device is online', () async {
      //act
      await repositoryImpl.rateRecommendation();
      //assert
      verify(networkInfo!.isConnected);
    });
    test(
        'should return a unit when call to remote data source is successfull',
            () async {
          //arrange
          when(remoteDataService!.rateRecommendationFlow(feedback: tFeedbackModel))
              .thenAnswer((_) async => unit);
          //act
          final result = await repositoryImpl.rateRecommendation(feedback: tFeedbackModel);
          //assert
          verify(remoteDataService!.rateRecommendationFlow(feedback: tFeedbackModel));
          expect(result, const Right(unit));
        });
    test(
        'should return a ServerFailure when call to remoteDataSource is unsuccessfull.',
            () async {
          //arrange
          when(remoteDataService!.rateRecommendationFlow(feedback: tFeedbackModel)).thenThrow(ServerException());
          //act
          final result = await repositoryImpl.rateRecommendation(feedback: tFeedbackModel);
          //assert

          expect(result, Left(ServerFailure()));
        });
  });

  test('DEVICE OFFLINE : rateRecommendationFlow should return DeviceOfflineFailure',
          () async {
        when(networkInfo!.isConnected).thenAnswer((_) async => false);
        //act
        final result = await repositoryImpl.rateRecommendation(feedback: tFeedbackModel);
        //assert
        expect(result, Left(DeviceOfflineFailure()));
      });
}