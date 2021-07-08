import 'package:dartz/dartz.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/repository/get-recorder-stats-repository-impl.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/get-recorder-stats-local-data-source.dart';

import 'get-recorder-stats-local-data-source_test.mocks.dart';

@GenerateMocks([FlutterSoundRecorder])
void main() {
  late MockFlutterSoundRecorder recorder;
  late GetRecorderStatsLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    recorder = MockFlutterSoundRecorder();
    localDataSourceImpl =
        GetRecorderStatsLocalDataSourceImpl(recorder: recorder);
  });
  // TODO Implement rights tests
  //? Actual tests go here
  group('DATA SOURCE : getRecorderStats', () {
    test('should send a GET request to specifed url', () async {
      when(recorder.onProgress).thenAnswer((_) => null);

      final result = await localDataSourceImpl.getDetails();

      verify(recorder.onProgress);
      expect(result, null);
    });
    test('should return getRecorderStats when call statusCode is 200',
        () async {
      //arrange
      when(recorder.onProgress).thenAnswer((_) => null);
      //act
      final result = await localDataSourceImpl.getDetails();
      //assert
      expect(result, null);
    });
    test('should throw ServerException when statusCode is not 200', () async {
      //arrange
      //act
      final call = localDataSourceImpl.getDetails;
      //assert
      expect(() => call(),
          throwsA(const TypeMatcher<VoiceNoteExceptionOperationException>()));
    });
  });
}
