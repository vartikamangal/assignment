import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/pause-voicenote.dart';

import 'clear-recording-data_test.mocks.dart';

void main() {
  late MockVoiceNotesPlayerRepository repository;
  late PauseVoiceNote useCase;

  setUp(() {
    repository = MockVoiceNotesPlayerRepository();
    useCase = PauseVoiceNote(voiceNotesPlayerRepository: repository);
  });

  const tUnit = unit;
  group('USECASE: voiceNotesPlayerRepository.pause()', () {
    test('Should pause the voice note recording', () async {
      when(repository.pause()).thenAnswer((_) async => const Right(tUnit));

      final Either<Failure, Unit> result = await useCase(NoParams());
      verify(repository.pause());
      expect(result, const Right(tUnit));
    });
  });
}
