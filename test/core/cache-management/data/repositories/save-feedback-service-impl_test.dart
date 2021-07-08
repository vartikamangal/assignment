import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/repositories/save-feedback-service-impl.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/save-feedback-local-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'save-feedback-service-impl_test.mocks.dart';

@GenerateMocks([SaveFeedbackLocalService, NetworkInfo])
void main() {
  late MockSaveFeedbackLocalService localService;
  late MockNetworkInfo networkInfo;
  late SaveFeedbackServiceImpl serviceImpl;
  BaseRepository baseRepository;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;

  setUp(() {
    localService = MockSaveFeedbackLocalService();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
    serviceImpl = SaveFeedbackServiceImpl(
        localService: localService, baseRepository: baseRepository);
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
    //   await serviceImpl.saveFeedback();
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
    //   final result = await serviceImpl.saveFeedback();
    //   //assert
    //   expect(result, Left(ServerFailure()));
    // });
  });
  test('DEVICE OFFLINE : setFeeling should return DeviceOfflineFailure',
          () async {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        //act
        final result = await serviceImpl.saveFeedback();
        //assert
        expect(result, Left(DeviceOfflineFailure()));
      });
}