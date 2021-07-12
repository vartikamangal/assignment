// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/features/home-management/data/repositories/mood-popup-shown-repository-impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/platform/network_info.dart' as _i5;
import 'package:tatsam_app_experimental/features/home-management/data/sources/mood-popup-shown-local-data-source.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeUnit extends _i1.Fake implements _i2.Unit {
  @override
  String toString() => super.toString();
}

/// A class which mocks [MoodPopupShownLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoodPopupShownLocalDataSource extends _i1.Mock
    implements _i3.MoodPopupShownLocalDataSource {
  MockMoodPopupShownLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool?> getMoodPopupShownStatus() =>
      (super.noSuchMethod(Invocation.method(#getMoodPopupShownStatus, []),
          returnValue: Future<bool?>.value()) as _i4.Future<bool?>);
  @override
  _i4.Future<_i2.Unit> toogleIsMoodPopupShownState() =>
      (super.noSuchMethod(Invocation.method(#toogleIsMoodPopupShownState, []),
              returnValue: Future<_i2.Unit>.value(_FakeUnit()))
          as _i4.Future<_i2.Unit>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i5.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
}