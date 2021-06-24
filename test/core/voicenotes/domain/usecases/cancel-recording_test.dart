import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/stop-recording-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/cancel-recording.dart';

class MockStopRecordingService extends Mock implements StopRecordingService {}

void main() {
  MockStopRecordingService service;
  CancelRecording useCase;

  setUp(() {
    service = MockStopRecordingService();
    useCase = CancelRecording(service: service);
  });

  const tUnit = unit;
  const String tPartialRecordingFileToDelete = '';
  group('USECASE: cacelRecording()', () {
    test('Should cancel recording for the voice note', () async {
      when(service.cancelRecording(
              partialRecordingFileToDelete: tPartialRecordingFileToDelete))
          .thenAnswer((_) async => const Right(tUnit));

      final result = await useCase(const CancelRecordingParams(
          incompleteRecordedFileToDelete: tPartialRecordingFileToDelete));

      verify(service.cancelRecording(
          partialRecordingFileToDelete: tPartialRecordingFileToDelete));
      expect(result, const Right(tUnit));
    });
  });
}
