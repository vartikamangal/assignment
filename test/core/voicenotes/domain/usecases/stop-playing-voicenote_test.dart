import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/stop-playing-voicenote.dart';
import 'stop-playing-voicenote_test.mocks.dart';

@GenerateMocks([VoiceNotesPlayerRepository])

void main() {
  MockVoiceNotesPlayerRepository ? repository;
  late StopPlayingVoiceNote useCase;

  setUp(() {
    repository = MockVoiceNotesPlayerRepository();
    useCase = StopPlayingVoiceNote(voiceNotesPlayerRepository: repository!);
  });

  const tUnit = unit;
  group('USECASE: voiceNotesPlayerRepository.stop()', () {
    test('Should stop playing voice note', () async {
      when(repository!.stop()).thenAnswer((_) async => const Right(tUnit));

      final Either<Failure, Unit>? result = await useCase(NoParams());
      verify(repository!.stop());
      expect(result, const Right(tUnit));
    });
  });
}
