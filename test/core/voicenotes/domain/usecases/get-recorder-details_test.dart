import 'package:dartz/dartz.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/get-recorder-stats-repository.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/get-recorder-details.dart';

class MockGetRecorderDetailsRepository extends Mock
    implements GetRecorderStatsRepository {}

void main(){
  MockGetRecorderDetailsRepository repository;
  GetRecorderDetails useCase;

  setUp(() {
    repository = MockGetRecorderDetailsRepository();
    useCase = GetRecorderDetails(repository: repository);
  });

  const Stream<RecordingDisposition> tRecordingDisposition=null;

  group('USECASE: getDetails()', () {
    test('Should get details of recorder from the repository', () async {
      when(repository.getDetails())
          .thenAnswer((_) async => const Right(tRecordingDisposition));

      final result = await useCase(NoParams());
      verify(repository.getDetails());
      expect(result, const Right(tRecordingDisposition));
    });
  });
}