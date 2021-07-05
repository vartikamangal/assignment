import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/play-voicenote.dart';

import 'clear-recording-data_test.mocks.dart';

void main() {
  late MockVoiceNotesPlayerRepository repository;
  late PlayVoiceNote useCase;

  setUp(() {
    repository = MockVoiceNotesPlayerRepository();
    useCase = PlayVoiceNote(voiceNotesPlayerRepository: repository);
  });

  group('USECASE: voiceNotesPlayerRepository.play()', () {
    test('Should play the voice note voice note', () async {
      when(repository.play(fileToPlay: "fileToPlay", smapleRate: 10))
          .thenAnswer((_) async => const Right(unit));

      final Either<Failure, Unit> result = await useCase(
          const PlayVoiceNoteParams(
              fileToPlay: "fileToPlay",
              codec: null,
              numChannels: null,
              smapleRate: 10,
              onCompleted: null));
      verify(repository.play(fileToPlay: "fileToPlay", smapleRate: 10));
      expect(result, const Right(unit));
    });
  });
}
