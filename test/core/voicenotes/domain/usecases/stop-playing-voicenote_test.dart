import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/stop-playing-voicenote.dart';

class MockVoiceNotesPlayerRepository extends Mock
    implements VoiceNotesPlayerRepository {}

void main() {
  MockVoiceNotesPlayerRepository repository;
  StopPlayingVoiceNote useCase;

  setUp(() {
    repository = MockVoiceNotesPlayerRepository();
    useCase = StopPlayingVoiceNote(voiceNotesPlayerRepository: repository);
  });

  const tUnit = unit;
  group('USECASE: voiceNotesPlayerRepository.stop()', () {
    test('Should stop playing voice note', () async {
      when(repository.stop()).thenAnswer((_) async => const Right(tUnit));

      final result = await useCase(NoParams());
      verify(repository.stop());
      expect(result, const Right(tUnit));
    });
  });
}
