// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/core/cache-management/domain/usecases/get-cached-mood_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cached-mood-model.dart'
    as _i6;
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/mood-cache-service.dart'
    as _i2;
import 'package:tatsam_app_experimental/core/error/failures.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [MoodCacheService].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoodCacheService extends _i1.Mock implements _i2.MoodCacheService {
  MockMoodCacheService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Either<_i5.Failure, _i4.Unit>?> cacheMood(
          {_i6.CachedMoodModel? mood}) =>
      (super.noSuchMethod(Invocation.method(#cacheMood, [], {#mood: mood}),
              returnValue: Future<_i4.Either<_i5.Failure, _i4.Unit>?>.value())
          as _i3.Future<_i4.Either<_i5.Failure, _i4.Unit>?>);
  @override
  _i3.Future<_i4.Either<_i5.Failure, _i6.CachedMoodModel>?> getCacheMood() =>
      (super.noSuchMethod(Invocation.method(#getCacheMood, []),
              returnValue:
                  Future<_i4.Either<_i5.Failure, _i6.CachedMoodModel>?>.value())
          as _i3.Future<_i4.Either<_i5.Failure, _i6.CachedMoodModel>?>);
}
