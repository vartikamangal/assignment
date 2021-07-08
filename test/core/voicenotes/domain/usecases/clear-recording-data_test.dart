import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/clear-recording-data.dart';
import 'clear-recording-data_test.mocks.dart';
// class MockVoiceNotesPlayerRepository extends Mock
//     implements VoiceNotesPlayerRepository {}

@GenerateMocks([VoiceNotesPlayerRepository])

void main() {
  MockVoiceNotesPlayerRepository?  repository;
  late ClearRecordingData useCase;

  setUp(() {
    repository = MockVoiceNotesPlayerRepository();
    useCase = ClearRecordingData(voiceNotesPlayerRepository: repository!);
  });
  const tUnit = unit;
  const audioFileToDelete = '';
  group('USECASE: voiceNotesPlayerRepository.cancel()', () {
    test('Should clear recording data from the repository', () async {
      when(repository!.cancel(audioFileToDelete: audioFileToDelete))
          .thenAnswer((_) async => const Right(tUnit));

      final Either<Failure, Unit>? result = await useCase(
          const ClearRecordingDataPrams(fileToDelete: audioFileToDelete));
      verify(repository!.cancel(audioFileToDelete: audioFileToDelete));
      expect(result, const Right(tUnit));
    });
  });
}
