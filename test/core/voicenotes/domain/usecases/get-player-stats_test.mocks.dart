// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/core/voicenotes/domain/usecases/get-player-stats_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;
import 'dart:ui' as _i7;

import 'package:dartz/dartz.dart' as _i2;
import 'package:flutter_sound_platform_interface/flutter_sound_platform_interface.dart'
    as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/error/failures.dart' as _i5;
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/player-stats.dart'
    as _i8;
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {
  @override
  String toString() => super.toString();
}

/// A class which mocks [VoiceNotesPlayerRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockVoiceNotesPlayerRepository extends _i1.Mock
    implements _i3.VoiceNotesPlayerRepository {
  MockVoiceNotesPlayerRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> play(
          {String? fileToPlay,
          _i6.Codec? codec,
          int? numChannels,
          int? smapleRate,
          _i7.VoidCallback? onCompleted}) =>
      (super.noSuchMethod(
              Invocation.method(#play, [], {
                #fileToPlay: fileToPlay,
                #codec: codec,
                #numChannels: numChannels,
                #smapleRate: smapleRate,
                #onCompleted: onCompleted
              }),
              returnValue: Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
                  _FakeEither<_i5.Failure, _i2.Unit>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> pause() =>
      (super.noSuchMethod(Invocation.method(#pause, []),
              returnValue: Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
                  _FakeEither<_i5.Failure, _i2.Unit>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> stop() =>
      (super.noSuchMethod(Invocation.method(#stop, []),
              returnValue: Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
                  _FakeEither<_i5.Failure, _i2.Unit>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> cancel(
          {String? audioFileToDelete}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #cancel, [], {#audioFileToDelete: audioFileToDelete}),
              returnValue: Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
                  _FakeEither<_i5.Failure, _i2.Unit>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i4.Stream<_i8.PlayerStats>>>
      getPlayerStats() => (super.noSuchMethod(
          Invocation.method(#getPlayerStats, []),
          returnValue: Future<
                  _i2.Either<_i5.Failure, _i4.Stream<_i8.PlayerStats>>>.value(
              _FakeEither<_i5.Failure, _i4.Stream<_i8.PlayerStats>>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i4.Stream<_i8.PlayerStats>>>);
}
