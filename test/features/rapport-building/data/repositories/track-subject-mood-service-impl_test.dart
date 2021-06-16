// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/instant.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-tracking-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/repository/track-subject-mood-service-impl.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/track-subject-mood-remote-service.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/track-mood-success.dart';

class MockTrackSubjectMoodRemoteService extends Mock
    implements TrackSubjectMoodRemoteService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockTrackSubjectMoodRemoteService remoteService;
  MockNetworkInfo networkInfo;
  TrackSubjectMoodServiceImpl serviceImpl;

  setUp(() {
    remoteService = MockTrackSubjectMoodRemoteService();
    networkInfo = MockNetworkInfo();
    serviceImpl = TrackSubjectMoodServiceImpl(
      service: remoteService,
      networkInfo: networkInfo,
    );
  });

  final MoodTracking tMoodTrack = MoodTrackingModel(
    activityType: 'ONBOARDING',
    createdWhen: Instant(time: DateTime.parse('2021-04-10 13:38:35.105')),
    id: 3,
    mood: 'NEUTRAL',
    moodDuration: 'SEVEN_DAYS',
    subjectId: const SubjectIdModel(id: '74a439b1-396b-43c2-a859-608c055a78a3'),
  );

  //? Helper functions
  void runTestsOnline(Callback callback) {
    group('DEVICE ONLINE : TrackSubjectMood', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      callback();
    });
  }

  void runTestsOffline(Callback callback) {
    group('DEVICE OFFLINE : TrackSubjectMood', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      callback();
    });
  }

  runTestsOnline(() {
    test('should check if the device is online', () async {
      //act
      await serviceImpl.trackMood(mood: tMoodTrack);
      //assert
      verify(networkInfo.isConnected);
    });
    test(
        'should return TrackMoodSuccess when the call to remote resource is successfull',
        () async {
      //arrange
      when(remoteService.trackMood(mood: tMoodTrack))
          .thenAnswer((realInvocation) async => TrackMoodSuccess());
      //act
      final result = await serviceImpl.trackMood(mood: tMoodTrack);
      //assert
      expect(result, Right(TrackMoodSuccess()));
    });
    test('should return ServerFailure when call to remote reousrce fails',
        () async {
      //arrange
      when(remoteService.trackMood(mood: tMoodTrack)).thenThrow(
        ServerException(),
      );
      //act
      final result = await serviceImpl.trackMood(mood: tMoodTrack);
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  runTestsOffline(() {
    test('should return DeviceOfflineFailure', () async {
      //act
      final result = await serviceImpl.trackMood(mood: tMoodTrack);
      //assert
      verifyZeroInteractions(remoteService);
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
