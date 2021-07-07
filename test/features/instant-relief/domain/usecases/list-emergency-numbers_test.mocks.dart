// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/features/instant-relief/domain/usecases/list-emergency-numbers_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-activity.dart'
    as _i7;
import 'package:tatsam_app_experimental/core/error/failures.dart' as _i5;
import 'package:tatsam_app_experimental/features/instant-relief/domain/entities/emergency-number.dart'
    as _i8;
import 'package:tatsam_app_experimental/features/instant-relief/domain/entities/instant-relief-area.dart'
    as _i6;
import 'package:tatsam_app_experimental/features/instant-relief/domain/repositories/instant-relief-repository.dart'
    as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [InstantReliefRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockInstantReliefRepository extends _i1.Mock
    implements _i2.InstantReliefRepository {
  MockInstantReliefRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Either<_i5.Failure, List<_i6.InstantReliefArea>>?>
      getReliefAreas() => (super.noSuchMethod(
              Invocation.method(#getReliefAreas, []),
              returnValue: Future<
                  _i4.Either<_i5.Failure,
                      List<_i6.InstantReliefArea>>?>.value())
          as _i3.Future<_i4.Either<_i5.Failure, List<_i6.InstantReliefArea>>?>);
  @override
  _i3.Future<_i4.Either<_i5.Failure, List<_i7.ActivityRecommendation>>?>
      getRecommendations({String? instantLifeArea}) => (super.noSuchMethod(
          Invocation.method(
              #getRecommendations, [], {#instantLifeArea: instantLifeArea}),
          returnValue: Future<
              _i4.Either<_i5.Failure, List<_i7.ActivityRecommendation>>?>.value()) as _i3
          .Future<_i4.Either<_i5.Failure, List<_i7.ActivityRecommendation>>?>);
  @override
  _i3.Future<_i4.Either<_i5.Failure, List<_i8.EmergencyNumber>>?>
      fetchEmergencyNumbers() => (super.noSuchMethod(
              Invocation.method(#fetchEmergencyNumbers, []),
              returnValue: Future<
                  _i4.Either<_i5.Failure, List<_i8.EmergencyNumber>>?>.value())
          as _i3.Future<_i4.Either<_i5.Failure, List<_i8.EmergencyNumber>>?>);
}
