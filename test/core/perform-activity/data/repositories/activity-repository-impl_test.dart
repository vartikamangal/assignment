import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/activity_rating_model.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/mood-feedback-model-for-activity.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/repositories/activity-repository-impl.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/sources/activity-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';

import 'activity-repository-impl_test.mocks.dart';

@GenerateMocks([AcitivityRemoteDataSource, NetworkInfo])
void main() {
  late MockAcitivityRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;
  BaseRepository baseRepository;
  late ActivityRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDataSource = MockAcitivityRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
    repositoryImpl = ActivityRepositoryImpl(
        baseRepository: baseRepository, remoteDataSource: remoteDataSource);
  });

  const tMoodFeedbackModelForActivity =
      MoodFeedbackModelForActivity(mood: 'mood', activityType: 'activityType');

  const tActivityRatingModel = ActivityRatingModel(
      subjectMoodVO: tMoodFeedbackModelForActivity,
      minutesSpent: 1,
      feedbackThoughts: 'feedbackThoughts',
      recommendationId: 'recommendationId',
      actionId: 1);
  const tUnit = unit;

  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : startActivity', body);
  }

  //! Actual tests go here
  runTestOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await repositoryImpl.startActivity();
    //   //assert
    //   verify(networkInfo!.isConnected);
    // });
    test(
        'should return a ActivityStatus when call to remote data source is successfull',
        () async {
      //arrange
      when(remoteDataSource.rateActivity(feedback: tActivityRatingModel))
          .thenAnswer((_) async => tUnit);
      //act
      final result =
          await repositoryImpl.rateActivity(feedback: tActivityRatingModel);
      //assert
      verify(remoteDataSource.rateActivity(feedback: tActivityRatingModel));
      expect(result, const Right(tUnit));
    });
    test(
        'should return a ServerFailure when call to remoteDataSource is unsuccessfull.',
        () async {
      //arrange
      when(remoteDataSource.rateActivity(feedback: tActivityRatingModel))
          .thenThrow(ServerException());
      //act
      final result =
          await repositoryImpl.rateActivity(feedback: tActivityRatingModel);
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  test('DEVICE OFFLINE : startActivity should return DeviceOfflineFailure',
      () async {
    when(networkInfo.isConnected).thenAnswer((_) async => false);
    //act
    final result =
        await repositoryImpl.rateActivity(feedback: tActivityRatingModel);
    //assert
    expect(result, Left(DeviceOfflineFailure()));
  });
}
