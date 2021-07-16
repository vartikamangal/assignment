// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-id.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/set-subject-mood.dart';
import 'set-subject-mood_test.mocks.dart';

@GenerateMocks([RapportBuildingRepository])
void main() {
  late MockRapportBuildingRepository? setSubjectMoodService;
  late SetSubjectMood useCase;

  const tMoodName = "NEUTRAL";
  const tActivityType = "ONBOARDING";
  final tMoodTracking = MoodTracking(
    activityType: tActivityType,
    createdWhen: DateTime.now(),
    id: 1,
    mood: tMoodName,
    moodDuration: 't mood duration',
    subjectId: const SubjectId('sss'),
  );

  group('USECASE : setSubjectMood', () {
    setUp(() {
      setSubjectMoodService = MockRapportBuildingRepository();
      useCase = SetSubjectMood(service: setSubjectMoodService!);
    });
    test('should set the name of user on [API] and return SetMoodSuccess',
        () async {
      //arrange
      when(setSubjectMoodService!.setSubjectMood(
        moodName: tMoodName,
        activityType: tActivityType,
      )).thenAnswer((_) async => Right(tMoodTracking));
      //act
      final result = await useCase(const SetSubjectMoodParams(
        moodName: tMoodName,
        activityType: tActivityType,
      ));
      //assert
      verify(
        setSubjectMoodService!.setSubjectMood(
          moodName: tMoodName,
          activityType: tActivityType,
        ),
      );
      expect(result, Right(tMoodTracking));
    });
  });
}
