// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/features/rapport-building/domain/usecases/set-subject-name_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/error/failures.dart' as _i5;
import 'package:tatsam_app_experimental/core/success/success-interface.dart'
    as _i11;
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-tracking-model.dart'
    as _i12;
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/feeling-duration.dart'
    as _i7;
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart'
    as _i9;
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood.dart'
    as _i6;
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/rapport-building-steps.dart'
    as _i8;
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart'
    as _i10;
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart'
    as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [RapportBuildingRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRapportBuildingRepository extends _i1.Mock
    implements _i2.RapportBuildingRepository {
  MockRapportBuildingRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Either<_i5.Failure, List<_i6.Mood>>?> getAllMoods() =>
      (super.noSuchMethod(Invocation.method(#getAllMoods, []),
              returnValue:
                  Future<_i4.Either<_i5.Failure, List<_i6.Mood>>?>.value())
          as _i3.Future<_i4.Either<_i5.Failure, List<_i6.Mood>>?>);
  @override
  _i3.Future<_i4.Either<_i5.Failure, List<_i7.FeelingDuration>>?>
      getAvailableDurations() => (super.noSuchMethod(
              Invocation.method(#getAvailableDurations, []),
              returnValue: Future<
                  _i4.Either<_i5.Failure, List<_i7.FeelingDuration>>?>.value())
          as _i3.Future<_i4.Either<_i5.Failure, List<_i7.FeelingDuration>>?>);
  @override
  _i3.Future<_i4.Either<_i5.Failure, _i8.RapportBuildingSteps>?>
      getRapportBuildingSteps({_i6.Mood? mood}) => (super.noSuchMethod(
              Invocation.method(#getRapportBuildingSteps, [], {#mood: mood}),
              returnValue: Future<
                  _i4.Either<_i5.Failure, _i8.RapportBuildingSteps>?>.value())
          as _i3.Future<_i4.Either<_i5.Failure, _i8.RapportBuildingSteps>?>);
  @override
  _i3.Future<_i4.Either<_i5.Failure, _i9.MoodTracking>?> setSubjectMood(
          {String? moodName, String? activityType}) =>
      (super.noSuchMethod(
              Invocation.method(#setSubjectMood, [],
                  {#moodName: moodName, #activityType: activityType}),
              returnValue:
                  Future<_i4.Either<_i5.Failure, _i9.MoodTracking>?>.value())
          as _i3.Future<_i4.Either<_i5.Failure, _i9.MoodTracking>?>);
  @override
  _i3.Future<_i4.Either<_i5.Failure, _i10.SubjectInformation>?> setSubjectName(
          {String? subjectName}) =>
      (super.noSuchMethod(
          Invocation.method(#setSubjectName, [], {#subjectName: subjectName}),
          returnValue: Future<
              _i4.Either<_i5.Failure, _i10.SubjectInformation>?>.value()) as _i3
          .Future<_i4.Either<_i5.Failure, _i10.SubjectInformation>?>);
  @override
  _i3.Future<_i4.Either<_i5.Failure, _i11.Success>?> trackMood(
          {_i12.MoodTrackingModel? mood}) =>
      (super.noSuchMethod(Invocation.method(#trackMood, [], {#mood: mood}),
              returnValue:
                  Future<_i4.Either<_i5.Failure, _i11.Success>?>.value())
          as _i3.Future<_i4.Either<_i5.Failure, _i11.Success>?>);
}
