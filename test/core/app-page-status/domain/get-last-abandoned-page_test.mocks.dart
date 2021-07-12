// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/core/app-page-status/domain/get-last-abandoned-page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/app-page-status/domain/entities/app-route.dart'
    as _i6;
import 'package:tatsam_app_experimental/core/app-page-status/domain/repository/app-page-status-repository.dart'
    as _i3;
import 'package:tatsam_app_experimental/core/error/failures.dart' as _i5;
import 'package:tatsam_app_experimental/features/hub/data/models/hub-status-model.dart'
    as _i7;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {
  @override
  String toString() => super.toString();
}

/// A class which mocks [AppPageStatusRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppPageStatusRepository extends _i1.Mock
    implements _i3.AppPageStatusRepository {
  MockAppPageStatusRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.AppRoute>> getLastAbandonedPage(
          {_i7.HubStatusModel? hubStatusModel}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getLastAbandonedPage, [], {#hubStatusModel: hubStatusModel}),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.AppRoute>>.value(
                  _FakeEither<_i5.Failure, _i6.AppRoute>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.AppRoute>>);
}