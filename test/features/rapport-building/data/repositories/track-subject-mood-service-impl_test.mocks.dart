// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/features/rapport-building/data/repositories/track-subject-mood-service-impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/platform/network_info.dart'
    as _i11;
import 'package:tatsam_app_experimental/features/rapport-building/data/models/feeling-duration-model.dart'
    as _i9;
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-model.dart'
    as _i8;
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-tracking-model.dart'
    as _i3;
import 'package:tatsam_app_experimental/features/rapport-building/data/models/rapport-building-steps-model.dart'
    as _i2;
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart'
    as _i4;
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/rapport-building-remote-data-source.dart'
    as _i6;
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart'
    as _i10;
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/track-mood-success.dart'
    as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeRapportBuildingStepsModel extends _i1.Fake
    implements _i2.RapportBuildingStepsModel {}

class _FakeMoodTrackingModel extends _i1.Fake implements _i3.MoodTrackingModel {
}

class _FakeSubjectInformationModel extends _i1.Fake
    implements _i4.SubjectInformationModel {}

class _FakeTrackMoodSuccess extends _i1.Fake implements _i5.TrackMoodSuccess {}

/// A class which mocks [RapportBuildingRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRapportBuildingRemoteDataSource extends _i1.Mock
    implements _i6.RapportBuildingRemoteDataSource {
  MockRapportBuildingRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i8.MoodModel>> getMoods() =>
      (super.noSuchMethod(Invocation.method(#getMoods, []),
              returnValue: Future<List<_i8.MoodModel>>.value(<_i8.MoodModel>[]))
          as _i7.Future<List<_i8.MoodModel>>);
  @override
  _i7.Future<List<_i9.FeelingDurationModel>> getAvailableDurations() =>
      (super.noSuchMethod(Invocation.method(#getAvailableDurations, []),
              returnValue: Future<List<_i9.FeelingDurationModel>>.value(
                  <_i9.FeelingDurationModel>[]))
          as _i7.Future<List<_i9.FeelingDurationModel>>);
  @override
  _i7.Future<_i2.RapportBuildingStepsModel> getRapportBuildingSteps(
          {_i8.MoodModel? mood}) =>
      (super.noSuchMethod(
              Invocation.method(#getRapportBuildingSteps, [], {#mood: mood}),
              returnValue: Future<_i2.RapportBuildingStepsModel>.value(
                  _FakeRapportBuildingStepsModel()))
          as _i7.Future<_i2.RapportBuildingStepsModel>);
  @override
  _i7.Future<_i3.MoodTrackingModel> setMood(
          {String? moodName, String? activityType}) =>
      (super.noSuchMethod(
          Invocation.method(
              #setMood, [], {#moodName: moodName, #activityType: activityType}),
          returnValue: Future<_i3.MoodTrackingModel>.value(
              _FakeMoodTrackingModel())) as _i7.Future<_i3.MoodTrackingModel>);
  @override
  _i7.Future<_i4.SubjectInformationModel> setSubjectName({String? name}) =>
      (super.noSuchMethod(Invocation.method(#setSubjectName, [], {#name: name}),
              returnValue: Future<_i4.SubjectInformationModel>.value(
                  _FakeSubjectInformationModel()))
          as _i7.Future<_i4.SubjectInformationModel>);
  @override
  _i7.Future<_i5.TrackMoodSuccess> trackMood({_i10.MoodTracking? mood}) =>
      (super.noSuchMethod(Invocation.method(#trackMood, [], {#mood: mood}),
              returnValue:
                  Future<_i5.TrackMoodSuccess>.value(_FakeTrackMoodSuccess()))
          as _i7.Future<_i5.TrackMoodSuccess>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i11.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
}
