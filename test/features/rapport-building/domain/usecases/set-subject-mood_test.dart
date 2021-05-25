import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/set-mood-success.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/set-subject-mood-service.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/set-subject-mood.dart';

class MockSetSubjectMoodService extends Mock implements SetSubjectMoodService {}

void main() {
  MockSetSubjectMoodService setSubjectMoodService;
  SetSubjectMood useCase;

  const tMoodName = "NEUTRAL";
  const tActivityType = "ONBOARDING";
  final tSetMoodSuccess = SetMoodSuccess();

  group('USECASE : setSubjectMood', () {
    setUp(() {
      setSubjectMoodService = MockSetSubjectMoodService();
      useCase = SetSubjectMood(service: setSubjectMoodService);
    });
    test('should set the name of user on [API] and return SetMoodSuccess',
        () async {
      //arrange
      when(setSubjectMoodService.setSubjectMood(
        moodName: tMoodName,
        activityType: tActivityType,
      )).thenAnswer((_) async => Right(tSetMoodSuccess));
      //act
      final result = await useCase(const SetSubjectMoodParams(
        moodName: tMoodName,
        activityType: tActivityType,
      ));
      //assert
      expect(result, Right(tSetMoodSuccess));
    });
  });
}
