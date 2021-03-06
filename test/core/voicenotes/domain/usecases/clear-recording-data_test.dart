import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/clear-recording-data.dart';

class MockVoiceNotesPlayerRepository extends Mock
    implements VoiceNotesPlayerRepository {}

void main() {
  MockVoiceNotesPlayerRepository repository;
  ClearRecordingData useCase;

  setUp(() {
    repository = MockVoiceNotesPlayerRepository();
    useCase = ClearRecordingData(voiceNotesPlayerRepository: repository);
  });
  const tUnit = unit;
  const audioFileToDelete = '';
  group('USECASE: voiceNotesPlayerRepository.cancel()', () {
    test('Should clear recording data from the repository', () async {
      when(repository.cancel(audioFileToDelete: audioFileToDelete))
          .thenAnswer((_) async => const Right(tUnit));

      final result = await useCase(
          const ClearRecordingDataPrams(fileToDelete: audioFileToDelete));
      verify(repository.cancel(audioFileToDelete: audioFileToDelete));
      expect(result, const Right(tUnit));
    });
  });
}
