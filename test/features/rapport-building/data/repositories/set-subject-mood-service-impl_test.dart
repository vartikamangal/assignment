import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/repository/set-subject-mood-service-impl.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/set-subject-mood-remote-service.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/set-mood-success.dart';

class MockSetSubjectMoodRemoteService extends Mock
    implements SetSubjectMoodRemoteService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockNetworkInfo networkInfo;
  MockSetSubjectMoodRemoteService remoteService;
  SetSubjectMoodServiceImpl serviceImpl;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteService = MockSetSubjectMoodRemoteService();
    serviceImpl = SetSubjectMoodServiceImpl(
      service: remoteService,
      networkInfo: networkInfo,
    );
  });

  // Helper vars
  const tMood = 'NEUTRAL';
  const tActivityType = 'ONBOARDING';

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : SetSubjectMood', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : SetSubjectMood', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
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
      verify(networkInfo.isConnected);
    });
    test(
        'should return SetMoodSuccess if call to remote data source is successfull',
        () async {
      //arrange
      when(remoteService.setMood(
        moodName: tMood,
        activityType: tActivityType,
      )).thenAnswer((_) async => SetMoodSuccess());
      //act
      final result = await serviceImpl.setSubjectMood(
        moodName: tMood,
        activityType: tActivityType,
      );
      //assert
      verify(remoteService.setMood(
        moodName: tMood,
        activityType: tActivityType,
      ));
      expect(result, Right(SetMoodSuccess()));
    });
    test('should return ServerFailure when the call to remoteService fails',
        () async {
      //arrange
      when(remoteService.setMood(
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
