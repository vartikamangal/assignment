import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-scedule-guided-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/guided-activity-recommendation-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/path-information-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/get-activity-schedule-guided-plan-repository-impl.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-activity-schedule-for-guided-plan-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity-schedule-guided.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/path-information-guided.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'get-activity-schedule-guided-plan-repository-impl_test.mocks.dart';

@GenerateMocks([GetActivityScheduleForGuidedPlanRemoteDataSource, NetworkInfo])
void main() {
  GetActivityScheduleForGuidedPlanRemoteDataSource? remoteDataSource;
  late MockNetworkInfo networkInfo;
  late GetActivityScheduleGuidedPlanRepositoryImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteDataSource = MockGetActivityScheduleForGuidedPlanRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    repositoryImpl = GetActivityScheduleGuidedPlanRepositoryImpl(
      remoteDataSource: remoteDataSource,
      baseRepository: baseRepository,
    );
  });
  //
  //  late final Future<ActivityScheduleGuidedModel> tActivityScheduled = ActivityScheduleGuidedModel
  //    (
  //   id: 3441,
  //   tags: [],
  //   pathInformation: PathInformation(description: '', subtitle: '', title: '', helpContent: '', id: 1, lengthOfPlan: 10),
  //   activitySchedule:  []
  //
  // ) as Future<ActivityScheduleGuidedModel>;

  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : GetScheduledActivity', body);
  }

  //! Actual tests go here
  runTestOnline(() {
    test('should check if the device is online', () async {
      //arrange
      when(remoteDataSource!.getSchedule()).thenThrow(ServerException());
      //act
      await repositoryImpl.getSchedule();
      //assert
      verify(networkInfo.isConnected);
    });
    // test(
    //     'should return a scheduledactivity when call to remote data source is successfull',
    //     () async {
    //   //arrange
    //   when(remoteDataSource!.getSchedule())
    //       .thenAnswer((_) async => tActivityScheduled);
    //   //act
    //   final result = await repositoryImpl.getSchedule();
    //   //assert
    //   verify(remoteDataSource!.getSchedule());
    //   expect(result,  Right(tActivityScheduled));
    // });
    test(
        'should return a ServerFailure when call to remoteDataSource is unsuccessfull.',
        () async {
      //arrange
      when(remoteDataSource!.getSchedule()).thenThrow(ServerException());
      //act
      final result = await repositoryImpl.getSchedule();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  test('DEVICE OFFLINE : GetSchedule should return DeviceOfflineFailure',
      () async {
    when(networkInfo.isConnected).thenAnswer((_) async => false);
    //act
    final result = await repositoryImpl.getSchedule();
    //assert
    expect(result, Left(DeviceOfflineFailure()));
  });
}
