import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/play-voicenote.dart';

class MockPlayVoiceNoteRepository extends Mock
    implements VoiceNotesPlayerRepository {}

void main(){
  MockPlayVoiceNoteRepository repository;
  PlayVoiceNote useCase;

  setUp(() {
    repository = MockPlayVoiceNoteRepository();
    useCase = PlayVoiceNote(voiceNotesPlayerRepository: repository);
  });

  group('USECASE: voiceNotesPlayerRepository.play()', () {
    test('Should play the voice note voice note', () async {
      when(repository.play(fileToPlay: "fileToPlay", codec: null, numChannels: null, smapleRate: 10, onCompleted:null))
          .thenAnswer((_) async => const Right(unit));

      final result = await useCase( const PlayVoiceNoteParams(fileToPlay: "fileToPlay", codec: null, numChannels: null, smapleRate: 10, onCompleted:null));
      verify(repository.play(fileToPlay: "fileToPlay", codec: null, numChannels: null, smapleRate: 10, onCompleted:null));
      expect(result,  const Right(unit));
    });
  });
}