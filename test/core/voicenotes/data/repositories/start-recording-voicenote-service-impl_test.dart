import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/repository/start-recording-voicenote-service-impl.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/start-recording-voicenote-local-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/recording-started-status.dart';

import 'start-recording-voicenote-service-impl_test.mocks.dart';

@GenerateMocks([StartRecordingVoiceNoteLocalService, NetworkInfo])
void main() {
  late MockStartRecordingVoiceNoteLocalService localService;
  late MockNetworkInfo networkInfo;
  late StartRecordingVoiceNoteServiceImpl serviceImpl;

  setUp(() {
    localService = MockStartRecordingVoiceNoteLocalService();
    networkInfo = MockNetworkInfo();
    serviceImpl =
        StartRecordingVoiceNoteServiceImpl(localService: localService);
  });
  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : startRecording', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : startRecording', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await serviceImpl.startRecodring();
    //   //assert
    //   verify(networkInfo.isConnected);
    // });
    test('should start recording voice note service', () async {
      //arrange
      when(localService.startRecording()).thenAnswer((_) async =>
          const RecordingStarted(recordingStatus: 'Recording started'));
      //act
      final result = await serviceImpl.startRecodring();
      //assert
      verify(localService.startRecording());
      expect(result,
          const Right(RecordingStarted(recordingStatus: 'Recording started')));
    });
    test('should return VoiceNoteFailure when the call to localService fails',
        () async {
      //arrange
      when(localService.startRecording())
          .thenThrow(VoiceNoteExceptionOperationException());
      //act
      final result = await serviceImpl.startRecodring();
      //assert
      expect(result, Left(VoiceNoteFailure()));
    });
  });
  // runTestsOffline(() {
  //   test('should return DeviceOfflineFailure', () async {
  //     //act
  //     final result = await serviceImpl.startRecodring();
  //     //assert
  //     expect(result, Left(DeviceOfflineFailure()));
  //   });
  // });
}
