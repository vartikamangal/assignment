import 'package:dartz/dartz.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/permission-manager/permission-manager.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/start-recording-voicenote-local-service.dart';

import 'start-recording-voicenote-local-service_test.mocks.dart';

@GenerateMocks([FlutterSoundRecorder])
void main() {
  MockFlutterSoundRecorder? recorder;
  StartRecordingVoiceNoteLocalServiceImpl? localServiceImpl;
  PermissionManagerImpl? permissionManager;

  setUp(() {
    recorder = MockFlutterSoundRecorder();
    permissionManager = PermissionManagerImpl();
    localServiceImpl = StartRecordingVoiceNoteLocalServiceImpl(
        recorder: recorder, permissionManager: permissionManager);
  });

  const tRecordingStatus = false;

  group('DATA SOURCE : getRecorderStats', () {
    test('should send a GET request to specifed url', () async {
      // print('Hello');
      when(recorder!.isRecording).thenAnswer((_) => tRecordingStatus);

      await localServiceImpl!.startRecording();

      verify(recorder!.isRecording);
      // print('Hello');
      // expect(result, const Right(tRecordingStatus));
    });
    // test('should return getRecordetrStats when call statusCode is 200',
    //     () async {
    //   //arrange
    //   when(recorder.onProgress).thenAnswer((realInvocation) => null);
    //   //act
    //   final result = await localDataSourceImpl.getDetails();
    //   //assert
    //   expect(result, null);
    // });
    // test('should throw ServerException when statusCode is not 200', () async {
    //   //arrange
    //   //act
    //   final call = localServiceImpl.startRecording;
    //   //assert
    //   expect(() => call(),
    //       throwsA(const TypeMatcher<VoiceNoteExceptionOperationException>()));
    // });
  });
}