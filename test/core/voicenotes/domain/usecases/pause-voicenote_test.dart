import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/pause-voicenote.dart';

class MockVoiceNotePlayerRepository extends Mock
    implements VoiceNotesPlayerRepository {}

void main() {
  MockVoiceNotePlayerRepository repository;
  PauseVoiceNote useCase;

  setUp(() {
    repository = MockVoiceNotePlayerRepository();
    useCase = PauseVoiceNote(voiceNotesPlayerRepository: repository);
  });

  const tUnit = unit;
  group('USECASE: voiceNotesPlayerRepository.pause()', () {
    test('Should pause the voice note recording', () async {
      when(repository.pause()).thenAnswer((_) async => const Right(tUnit));

      final result = await useCase(NoParams());
      verify(repository.pause());
      expect(result, const Right(tUnit));
    });
  });
}
