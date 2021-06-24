import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/start-recording-voicenote-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/start-recording-voice-note.dart';

class MockStartRecordingVoiceNoteService extends Mock
    implements StartRecordingVoiceNoteService {}

void main() {
  MockStartRecordingVoiceNoteService service;
  StartRecordingVoiceNote useCase;

  setUp(() {
    service = MockStartRecordingVoiceNoteService();
    useCase = StartRecordingVoiceNote(service: service);
  });

  const tFilePath = 'file/path';
  group('USECASE: service.startRecording()', () {
    test('Should start recording voice note', () async {
      // TODO implement tests
    });
  });
}
