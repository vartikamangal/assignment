import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/save-feedback-local-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';

class MockSaveFeedbackLocalService extends Mock
    implements SaveFeedbackLocalService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockSaveFeedbackLocalService localService;
  MockNetworkInfo networkInfo;
  SaveFeedbackLocalServiceImpl serviceImpl;
  Box localClient;

  setUp(() {
    localService = MockSaveFeedbackLocalService();
    networkInfo = MockNetworkInfo();
    serviceImpl = SaveFeedbackLocalServiceImpl(localClient: localClient);
  });

  const tUnit = unit;

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : save-feedback-service', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : save feedback service', body);
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await serviceImpl.setFeeling(
    //       subjetcId: '',
    //       activityType: '',
    //       textFeedback: '',
    //       voiceNote: '',
    //       timeOfCreation: '',
    //       boxKey: '');
    //   //assert
    //   verify(networkInfo.isConnected);
    // });
    test('should set feeling to a local data source', () async {
      //arrange
      when(localService.setFeeling(
              subjetcId: '',
              activityType: '',
              textFeedback: '',
              voiceNote: '',
              timeOfCreation: '',
              boxKey: ''))
          .thenAnswer((_) async => tUnit);
      //act
      final result = await localService.setFeeling(
          subjetcId: '',
          activityType: '',
          textFeedback: '',
          voiceNote: '',
          timeOfCreation: '',
          boxKey: '');
      //assert
      verify(localService.setFeeling(
          subjetcId: '',
          activityType: '',
          textFeedback: '',
          voiceNote: '',
          timeOfCreation: '',
          boxKey: ''));
      expect(result, tUnit);
    });
    // test('should return ServerFailure when the call to remoteService fails',
    //     () async {
    //   //arrange
    //   when(localService.setFeeling(
    //           subjetcId: '',
    //           activityType: '',
    //           textFeedback: '',
    //           voiceNote: '',
    //           timeOfCreation: '',
    //           boxKey: ''))
    //       .thenThrow(ServerException());
    //   //act
    //   final result = await serviceImpl.setFeeling(
    //       subjetcId: '',
    //       activityType: '',
    //       textFeedback: '',
    //       voiceNote: '',
    //       timeOfCreation: '',
    //       boxKey: '');
    //   //assert
    //   expect(result, Left(ServerFailure()));
    // });
  });
  test('DEVICE OFFLINE : setFeeling should return DeviceOfflineFailure',
      () async {
    when(networkInfo.isConnected).thenAnswer((_) async => false);
    //act
    final result = await localService.setFeeling(
        subjetcId: '',
        activityType: '',
        textFeedback: '',
        voiceNote: '',
        timeOfCreation: '',
        boxKey: '');
    //assert
    expect(result, null);
  });
}
