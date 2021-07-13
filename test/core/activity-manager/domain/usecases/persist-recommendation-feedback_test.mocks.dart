// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/core/activity-manager/domain/usecases/persist-recommendation-feedback_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/activity/data/models/activity-status-model.dart'
    as _i6;
import 'package:tatsam_app_experimental/core/cache-manager/domain/entities/activity-feedback.dart'
    as _i7;
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/persist-activity-feedback-repository.dart'
    as _i3;
import 'package:tatsam_app_experimental/core/error/failures.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {
  @override
  String toString() => super.toString();
}

/// A class which mocks [RecommendationFeedbackService].
///
/// See the documentation for Mockito's code generation for more information.
class MockRecommendationFeedbackService extends _i1.Mock
    implements _i3.RecommendationFeedbackService {
  MockRecommendationFeedbackService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> persistFeedback(
          {_i6.ActivityStatusModel? activityStatusModel,
          String? textInput,
          String? voiceNoteInput}) =>
      (super.noSuchMethod(
              Invocation.method(#persistFeedback, [], {
                #activityStatusModel: activityStatusModel,
                #textInput: textInput,
                #voiceNoteInput: voiceNoteInput
              }),
              returnValue: Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
                  _FakeEither<_i5.Failure, _i2.Unit>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.RecommendationInput>>>
      getpersistedFeedbacks() => (super.noSuchMethod(
          Invocation.method(#getpersistedFeedbacks, []),
          returnValue: Future<
                  _i2.Either<_i5.Failure, List<_i7.RecommendationInput>>>.value(
              _FakeEither<_i5.Failure, List<_i7.RecommendationInput>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i7.RecommendationInput>>>);
}
