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
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-tracking-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/repository/rapport-building-repository-impl.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/rapport-building-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/track-mood-success.dart';
import 'track-subject-mood-service-impl_test.mocks.dart';

@GenerateMocks([RapportBuildingRemoteDataSource, NetworkInfo])
void main() {
  MockRapportBuildingRemoteDataSource? remoteService;
  MockNetworkInfo? networkInfo;
  late RapportBuildingRepositoryImpl serviceImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteService = MockRapportBuildingRemoteDataSource();
    networkInfo = MockNetworkInfo();
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

  final MoodTracking tMoodTrack = MoodTrackingModel(
    activityType: 'ONBOARDING',
    createdWhen: DateTime.parse('2021-04-10 13:38:35.105'),
    id: 3,
    mood: 'NEUTRAL',
    moodDuration: 'SEVEN_DAYS',
    subjectId: const SubjectIdModel(id: '74a439b1-396b-43c2-a859-608c055a78a3'),
  );

  //? Helper functions
  void runTestsOnline(Callback callback) {
    group('DEVICE ONLINE : TrackSubjectMood', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      callback();
    });
  }

  void runTestsOffline(Callback callback) {
    group('DEVICE OFFLINE : TrackSubjectMood', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => false);
      });
      callback();
    });
  }

  runTestsOnline(() {
    test('should check if the device is online', () async {
      //arrange
      when(remoteService!.trackMood(mood: tMoodTrack)).thenThrow(
        ServerException(),
      );
      //act
      await serviceImpl.trackMood(mood: tMoodTrack as MoodTrackingModel);
      //assert
      verify(networkInfo!.isConnected);
    });
    test(
        'should return TrackMoodSuccess when the call to remote resource is successfull',
        () async {
      //arrange
      when(remoteService!.trackMood(mood: tMoodTrack))
          .thenAnswer((realInvocation) async => TrackMoodSuccess());
      //act
      final result =
          await serviceImpl.trackMood(mood: tMoodTrack as MoodTrackingModel);
      //assert
      expect(result, Right(TrackMoodSuccess()));
    });
    test('should return ServerFailure when call to remote reousrce fails',
        () async {
      //arrange
      when(remoteService!.trackMood(mood: tMoodTrack)).thenThrow(
        ServerException(),
      );
      //act
      final result =
          await serviceImpl.trackMood(mood: tMoodTrack as MoodTrackingModel);
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  runTestsOffline(() {
    test('should return DeviceOfflineFailure', () async {
      //act
      final result =
          await serviceImpl.trackMood(mood: tMoodTrack as MoodTrackingModel);
      //assert
      verifyZeroInteractions(remoteService);
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
