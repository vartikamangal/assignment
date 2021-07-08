import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/file-manager/file-manager.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/stop-recording-local-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/recording-stopped.dart';
import 'package:matcher/matcher.dart';
import 'stop-recording-local-service_test.mocks.dart';

@GenerateMocks([FlutterSoundRecorder])
void main() {
  late MockFlutterSoundRecorder recorder;
  late StopRecordingLocalServiceImpl serviceImpl;
  late FileUtilsImpl fileUtils;
  Box? box;

  setUp(() {
    recorder = MockFlutterSoundRecorder();
    fileUtils = FileUtilsImpl(box: box);
    serviceImpl =
        StopRecordingLocalServiceImpl(recorder: recorder, fileUtils: fileUtils);
  });
  group('DATA SOURCE : stopRecording', () {
    test('should stop recording of voice notes', () async {
      when(recorder.stopRecorder())
          .thenAnswer((_) async => 'Recording stopped');

      final result = await recorder.stopRecorder();

      verify(recorder.stopRecorder());
      expect(result, 'Recording stopped');
    });
    // test('should return stopRecording when the recording is stopped', () async {
    //   //arrange
    //   when(recorder.startRecorder())
    //       .thenAnswer((_) async => 'Recording stopped');
    //   //act
    //   final result = await recorder.stopRecorder();
    //   //assert
    //   expect(result, 'Recording stopped');
    // });
    test('should throw VoiceNoteException when recording is not stopped',
        () async {
      //arrange
      //act
      final call = serviceImpl.stopRecording;
      //assert
      expect(() => call(),
          throwsA(const TypeMatcher<VoiceNoteExceptionOperationException>()));
    });
  });
}
