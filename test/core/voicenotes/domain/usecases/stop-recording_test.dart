import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/recording-stopped.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/stop-recording-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/stop-recording.dart';

class MockStopRecordingService extends Mock implements StopRecordingService {}

void main() {
  MockStopRecordingService service;
  StopRecording useCase;

  setUp(() {
    service = MockStopRecordingService();
    useCase = StopRecording(service: service);
  });

  const tSuccess = RecordingStopped(status: 'Recording Stopped');
  group('USECASE: service.stopRecording()', () {
    test('Should stop recording', () async {
      when(service.stopRecording())
          .thenAnswer((_) async => const Right(tSuccess));

      final result = await useCase(NoParams());
      verify(service.stopRecording());
      expect(result, const Right(tSuccess));
    });
  });
}
