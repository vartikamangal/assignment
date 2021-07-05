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
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-tracking-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/repository/rapport-building-repository-impl.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/rapport-building-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-id.dart';

class MockSetSubjectMoodRemoteService extends Mock
    implements RapportBuildingRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockNetworkInfo? networkInfo;
  MockSetSubjectMoodRemoteService? remoteService;
  late RapportBuildingRepositoryImpl serviceImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteService = MockSetSubjectMoodRemoteService();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    serviceImpl = RapportBuildingRepositoryImpl(
      remoteDataSource: remoteService,
      baseRepository: baseRepository,
    );
  });

  // Helper vars
  const tMood = 'NEUTRAL';
  const tActivityType = 'ONBOARDING';

  final tMoodTrackingModel = MoodTrackingModel(
    subjectId: const SubjectId('testId'),
    id: 1,
    moodDuration: 'test_duration',
    activityType: tActivityType,
    mood: tMood,
    createdWhen: DateTime.now(),
  );

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : SetSubjectMood', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : SetSubjectMood', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    test('should check if the device is online', () async {
      //act
      await serviceImpl.setSubjectMood(
        activityType: tActivityType,
        moodName: tMood,
      );
      //assert
      verify(networkInfo!.isConnected);
    });
    test(
        'should return SetMoodSuccess if call to remote data source is successfull',
        () async {
      //arrange
      when(remoteService!.setMood(
        moodName: tMood,
        activityType: tActivityType,
      )).thenAnswer(
        (_) async => tMoodTrackingModel,
      );
      //act
      final result = await serviceImpl.setSubjectMood(
        moodName: tMood,
        activityType: tActivityType,
      );
      //assert
      verify(remoteService!.setMood(
        moodName: tMood,
        activityType: tActivityType,
      ));
      expect(result, Right(tMoodTrackingModel));
    });
    test('should return ServerFailure when the call to remoteService fails',
        () async {
      //arrange
      when(remoteService!.setMood(
        moodName: tMood,
        activityType: tActivityType,
      )).thenThrow(ServerException());
      //act
      final result = await serviceImpl.setSubjectMood(
        moodName: tMood,
        activityType: tActivityType,
      );
      //assert
      expect(result, Left(ServerFailure()));
    });
  });

  runTestsOffline(() {
    test('should return DeviceOfflineFailure', () async {
      //act
      final result = await serviceImpl.setSubjectMood(
        moodName: tMood,
        activityType: tActivityType,
      );
      //assert
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
