// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/features/focus/domain/usecases/get-issues_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/error/failures.dart' as _i5;
import 'package:tatsam_app_experimental/core/success/success-interface.dart'
    as _i7;
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue.dart'
    as _i6;
import 'package:tatsam_app_experimental/features/focus/domain/repositories/focus-repository.dart'
    as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [FocusRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFocusRepository extends _i1.Mock implements _i2.FocusRepository {
  MockFocusRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Either<_i5.Failure, List<_i6.Issue>>?> getIssues() =>
      (super.noSuchMethod(Invocation.method(#getIssues, []),
              returnValue:
                  Future<_i4.Either<_i5.Failure, List<_i6.Issue>>?>.value())
          as _i3.Future<_i4.Either<_i5.Failure, List<_i6.Issue>>?>);
  @override
  _i3.Future<_i4.Either<_i5.Failure, _i7.Success>?> setTarget(
          {_i6.Issue? issue}) =>
      (super.noSuchMethod(Invocation.method(#setTarget, [], {#issue: issue}),
              returnValue:
                  Future<_i4.Either<_i5.Failure, _i7.Success>?>.value())
          as _i3.Future<_i4.Either<_i5.Failure, _i7.Success>?>);
  @override
  _i3.Future<_i4.Either<_i5.Failure, _i7.Success>?> removeIssue(
          {_i6.Issue? issue}) =>
      (super.noSuchMethod(Invocation.method(#removeIssue, [], {#issue: issue}),
              returnValue:
                  Future<_i4.Either<_i5.Failure, _i7.Success>?>.value())
          as _i3.Future<_i4.Either<_i5.Failure, _i7.Success>?>);
}