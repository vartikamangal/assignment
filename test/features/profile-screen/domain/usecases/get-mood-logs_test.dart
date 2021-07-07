// Package Imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// Project Imports:
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/repositories/profile-details-repository.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/usecases/get-mood-logs.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-id.dart';
import 'get-mood-logs_test.mocks.dart';
@GenerateMocks([ProfileDetailsRepository])

void main() {
  late MockProfileDetailsRepository repository;
  late GetMoodLogs useCase;

  setUp(() {
    repository = MockProfileDetailsRepository();
    useCase = GetMoodLogs(repository: repository);
  });

  const tMoodName = "NEUTRAL";
  const tActivityType = "ONBOARDING";
  final tMoodTracking = <MoodTracking>[
    MoodTracking(
      activityType: tActivityType,
      createdWhen: DateTime.now(),
      id: 1,
      mood: tMoodName,
      moodDuration: 't mood duration',
      subjectId: const SubjectId('sss'),
    )
  ];
  group("USECASE : getMoodLogs()", () {
    test('should get all the possible moods logs from the repository',
        () async {
      //arrange
      when(repository.getMoodLogs())
          .thenAnswer((_) async => Right(tMoodTracking));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getMoodLogs());
      expect(result, Right(tMoodTracking));
    });
  });
}
