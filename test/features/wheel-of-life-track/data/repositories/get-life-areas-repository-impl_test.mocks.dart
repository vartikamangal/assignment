// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/features/wheel-of-life-track/data/repositories/get-life-areas-repository-impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/platform/network_info.dart'
    as _i10;
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model-for-prioritization.dart'
    as _i8;
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart'
    as _i7;
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart'
    as _i2;
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/satisfaction-ratings-model.dart'
    as _i9;
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/sources/wheel-of-life-remote-data-source.dart'
    as _i5;
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/rated-satisfaction-success.dart'
    as _i4;
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/success-prioritize.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeRatingScaleModel extends _i1.Fake implements _i2.RatingScaleModel {}

class _FakeSuccessPrioritize extends _i1.Fake implements _i3.SuccessPrioritize {
}

class _FakeSuccessRatedSatisfaction extends _i1.Fake
    implements _i4.SuccessRatedSatisfaction {}

/// A class which mocks [WheelOfLifeRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWheelOfLifeRemoteDataSource extends _i1.Mock
    implements _i5.WheelOfLifeRemoteDataSource {
  MockWheelOfLifeRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i7.LifeAreaModel>> getAreas() =>
      (super.noSuchMethod(Invocation.method(#getAreas, []),
              returnValue:
                  Future<List<_i7.LifeAreaModel>>.value(<_i7.LifeAreaModel>[]))
          as _i6.Future<List<_i7.LifeAreaModel>>);
  @override
  _i6.Future<_i2.RatingScaleModel> getRatingScale() =>
      (super.noSuchMethod(Invocation.method(#getRatingScale, []),
              returnValue:
                  Future<_i2.RatingScaleModel>.value(_FakeRatingScaleModel()))
          as _i6.Future<_i2.RatingScaleModel>);
  @override
  _i6.Future<_i3.SuccessPrioritize> prioritize(
          {_i8.LifeAreaModelForPrioritization? lifeAreas}) =>
      (super.noSuchMethod(
              Invocation.method(#prioritize, [], {#lifeAreas: lifeAreas}),
              returnValue:
                  Future<_i3.SuccessPrioritize>.value(_FakeSuccessPrioritize()))
          as _i6.Future<_i3.SuccessPrioritize>);
  @override
  _i6.Future<_i4.SuccessRatedSatisfaction> rateSatisfaction(
          {_i9.SatisfactionRatingsModel? ratings}) =>
      (super.noSuchMethod(
              Invocation.method(#rateSatisfaction, [], {#ratings: ratings}),
              returnValue: Future<_i4.SuccessRatedSatisfaction>.value(
                  _FakeSuccessRatedSatisfaction()))
          as _i6.Future<_i4.SuccessRatedSatisfaction>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i10.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
}
