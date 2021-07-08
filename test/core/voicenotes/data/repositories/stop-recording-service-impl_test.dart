import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/repository/stop-recording-service-impl.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/stop-recording-local-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/recording-stopped.dart';

import 'stop-recording-service-impl_test.mocks.dart';

@GenerateMocks([StopRecordingLocalService, NetworkInfo])
void main() {
  late MockStopRecordingLocalService localService;
  late MockNetworkInfo networkInfo;
  late StopRecordingServiceImpl serviceImpl;

  setUp(() {
    localService = MockStopRecordingLocalService();
    networkInfo = MockNetworkInfo();
    serviceImpl = StopRecordingServiceImpl(localService: localService);
  });
  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : stopRecording', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : stopRecording', () {
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
    test('should stop recording voice note service', () async {
      //arrange
      when(localService.stopRecording())
          .thenAnswer((_) async => const RecordingStopped(status: 'stopped'));
      //act
      final result = await serviceImpl.stopRecording();
      //assert
      verify(localService.stopRecording());
      expect(result, const Right(RecordingStopped(status: 'stopped')));
    });
    test('should return VoiceNoteFailure when the call to localService fails',
        () async {
      //arrange
      when(localService.stopRecording())
          .thenThrow(VoiceNoteExceptionOperationException());
      //act
      final result = await serviceImpl.stopRecording();
      //assert
      expect(result, Left(VoiceNoteFailure()));
    });
  });
  // runTestsOffline(() {
  //   test('should return DeviceOfflineFailure', () async {
  //     //act
  //     final result = await serviceImpl.stopRecording();
  //     //assert
  //     expect(result, Left(DeviceOfflineFailure()));
  //   });
  // });
}
