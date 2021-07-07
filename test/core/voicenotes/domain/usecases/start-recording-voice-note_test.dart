import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/recording-started-status.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/start-recording-voicenote-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/start-recording-voice-note.dart';

class MockStartRecordingVoiceNoteService extends Mock
    implements StartRecordingVoiceNoteService {}

void main() {
  MockStartRecordingVoiceNoteService? service;
  late StartRecordingVoiceNote useCase;

  setUp(() {
    service = MockStartRecordingVoiceNoteService();
    useCase = StartRecordingVoiceNote(service: service);
  });
 const tSuccess=RecordingStarted(recordingStatus: 'SUCCESS');
  const tFilePath = 'file/path';
  group('USECASE: service.startRecording()', () {
    test('Should start recording voice note', () async {
      when(service!.startRecodring(filePath: tFilePath,codec: null))
          .thenAnswer((_) async => const Right(tSuccess));

      final Either<Failure, Success>? result = await useCase(const StartRecordingVoiceNoteParams(filePath: tFilePath,codec: null));
      verify(service!.startRecodring(filePath: tFilePath,codec: null));
      expect(result, const Right(tSuccess));
    });
  });
}
