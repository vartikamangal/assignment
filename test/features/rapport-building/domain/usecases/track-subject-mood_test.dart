// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-tracking-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/track-mood-success.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/track-subject-mood-service.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/track-subject-mood.dart';

class MockTrackSubjectMoodService extends Mock
    implements TrackSubjectMoodService {}

void main() {
  MockTrackSubjectMoodService service;
  TrackSubjectMood useCase;

  setUp(() {
    service = MockTrackSubjectMoodService();
    useCase = TrackSubjectMood(service: service);
  });

  final tMoodTrack = MoodTrackingModel(
    activityType: 'ONBOARDING',
    createdWhen: DateTime.now(),
    id: 3,
    mood: 'NEUTRAL',
    moodDuration: 'SEVEN_DAYS',
    subjectId: const SubjectIdModel(id: '74a439b1-396b-43c2-a859-608c055a78a3'),
  );

  group('USECASE : trackSubjectMood', () {
    test('should set the mood-duration of subject with help of service',
        () async {
      //arrange
      when(service.trackMood(mood: tMoodTrack))
          .thenAnswer((_) async => Right(TrackMoodSuccess()));
      //act
      await useCase(TrackSubjectMoodParams(mood: tMoodTrack));
      //assert
      verify(service.trackMood(mood: tMoodTrack));
    });
  });
}
