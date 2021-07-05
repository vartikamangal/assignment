import 'package:dartz/dartz.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/get-recorder-stats-repository.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/get-recorder-details.dart';

import 'get-recorder-details_test.mocks.dart';

@GenerateMocks([GetRecorderStatsRepository])
void main() {
  late MockGetRecorderStatsRepository repository;
  late GetRecorderDetails useCase;

  setUp(() {
    repository = MockGetRecorderStatsRepository();
    useCase = GetRecorderDetails(repository: repository);
  });

  const Stream<RecordingDisposition>? tRecordingDisposition = null;

  group('USECASE: getDetails()', () {
    test('Should get details of recorder from the repository', () async {
      when(repository.getDetails())
          .thenAnswer((_) async => const Right(tRecordingDisposition));

      final result = await (useCase(NoParams())
          as Future<Either<Failure, Stream<RecordingDisposition>>>);
      verify(repository.getDetails());
      expect(result, const Right(tRecordingDisposition));
    });
  });
}
