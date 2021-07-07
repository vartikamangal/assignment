// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/features/home-management/domain/usecases/get-recommendations-by-action-time_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-activity.dart'
    as _i6;
import 'package:tatsam_app_experimental/core/error/failures.dart' as _i5;
import 'package:tatsam_app_experimental/features/home-management/domain/repositories/get-recommendations-by-action-time-repository.dart'
    as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [GetRecommendationsByActionTimeRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRecommendationsByActionTimeRepository extends _i1.Mock
    implements _i2.GetRecommendationsByActionTimeRepository {
  MockGetRecommendationsByActionTimeRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Either<_i5.Failure, List<_i6.ActivityRecommendation>>?>
      getRecommendations({String? actionTime}) => (super.noSuchMethod(
          Invocation.method(#getRecommendations, [], {#actionTime: actionTime}),
          returnValue: Future<
              _i4.Either<_i5.Failure,
                  List<_i6.ActivityRecommendation>>?>.value()) as _i3
          .Future<_i4.Either<_i5.Failure, List<_i6.ActivityRecommendation>>?>);
}
