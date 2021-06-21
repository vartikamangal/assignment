import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/feeling-duration.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/get-available-feeling-duration-repository.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/get-available-feeling-duration.dart';

class MockGetAvailableFeelingDurationRepository extends Mock
    implements GetAvailableFeelingDurationRepository {}

void main() {
  MockGetAvailableFeelingDurationRepository repository;
  GetAvailableFeelingDuration usecase;

  setUp(() {
    repository = MockGetAvailableFeelingDurationRepository();
    usecase = GetAvailableFeelingDuration(repository: repository);
  });

  final tMoodDurations = [
    const FeelingDuration(
      durationName: 'testDuration',
      durationSequence: 'testDurationSequence',
      durationDisplayName: 'more than T days',
    ),
    const FeelingDuration(
      durationName: 'testDuration',
      durationSequence: 'testDurationSequence',
      durationDisplayName: 'more than T-1 days',
    ),
    const FeelingDuration(
      durationName: 'testDuration',
      durationSequence: 'testDurationSequence',
      durationDisplayName: 'more than T-2 days',
    ),
  ];

  group('USECASE : getAvailableMoodDurations', () {
    test('should fetch [List<FeelingDuration>] from the repository', () async {
      //arrange
      when(repository.getAvailableDurations()).thenAnswer(
        (_) async => right(tMoodDurations),
      );
      //act
      final result = await usecase(NoParams());
      //assert
      verify(repository.getAvailableDurations());
      expect(result, right(tMoodDurations));
    });
  });
}
