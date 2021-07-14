// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/features/instant-relief/data/repositories/list-emergency-numbers-repository-impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/activity/data/models/activity-model.dart'
    as _i5;
import 'package:tatsam_app_experimental/core/platform/network_info.dart' as _i7;
import 'package:tatsam_app_experimental/features/instant-relief/data/models/emergency-number-model.dart'
    as _i6;
import 'package:tatsam_app_experimental/features/instant-relief/data/models/instant-relief-area-model.dart'
    as _i4;
import 'package:tatsam_app_experimental/features/instant-relief/data/sources/instant-relief-remote-data-source.dart'
    as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [InstantReliefRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockInstantReliefRemoteDataSource extends _i1.Mock
    implements _i2.InstantReliefRemoteDataSource {
  MockInstantReliefRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.InstantReliefAreaModel>> getReliefAreas() =>
      (super.noSuchMethod(Invocation.method(#getReliefAreas, []),
              returnValue: Future<List<_i4.InstantReliefAreaModel>>.value(
                  <_i4.InstantReliefAreaModel>[]))
          as _i3.Future<List<_i4.InstantReliefAreaModel>>);
  @override
  _i3.Future<List<_i5.ActivityModel>> getRecommendations(
          {String? instantLifeArea}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getRecommendations, [], {#instantLifeArea: instantLifeArea}),
              returnValue:
                  Future<List<_i5.ActivityModel>>.value(<_i5.ActivityModel>[]))
          as _i3.Future<List<_i5.ActivityModel>>);
  @override
  _i3.Future<List<_i6.EmergencyNumberModel>> fetchEmergencyNumbers() =>
      (super.noSuchMethod(Invocation.method(#fetchEmergencyNumbers, []),
              returnValue: Future<List<_i6.EmergencyNumberModel>>.value(
                  <_i6.EmergencyNumberModel>[]))
          as _i3.Future<List<_i6.EmergencyNumberModel>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i7.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
}
