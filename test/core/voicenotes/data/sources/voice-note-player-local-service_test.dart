import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/file-manager/file-manager.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/voice-note-player-local-service.dart';

import 'voice-note-player-local-service_test.mocks.dart';

@GenerateMocks([FlutterSoundPlayer])
void main() {
  late MockFlutterSoundPlayer player;
  late VoiceNotePlayerLocalServiceImpl serviceImpl;
  late FileUtilsImpl fileUtils;
  Box? box;

  setUp(() {
    player = MockFlutterSoundPlayer();
    fileUtils = FileUtilsImpl(box: box);
    serviceImpl =
        VoiceNotePlayerLocalServiceImpl(player: player, fileUtils: fileUtils);
  });
  group('DATA SOURCE : voiceNotePlayer', () {
    test('should stop voice note player', () async {
      when(player.stopPlayer()).thenAnswer((_) async => 'Recording stopped');

      await player.stopPlayer();

      verify(player.stopPlayer());
    });
    // test('should return stopRecording when the recording is stopped', () async {
    //   //arrange
    //   when(player.stopPlayer())
    //       .thenAnswer((_) async => 'Recording stopped');
    //   //act
    //   final result = await player.stopPlayer();
    //   //assert
    //   expect(result, 'Recording stopped');
    // });
    // test('should throw VoiceNoteException when recording is not stopped',
    //     () async {
    //   //arrange
    //   //act
    //   final call = player.stopPlayer;
    //   //assert
    //   expect(() => call(),
    //       throwsA(const TypeMatcher<VoiceNoteExceptionOperationException>()));
    // });
  });
}
