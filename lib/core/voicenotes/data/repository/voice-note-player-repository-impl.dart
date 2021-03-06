import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_platform_interface.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/voice-note-player-local-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/player-stats.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';

class VoiceNotePlayerRepositoryImpl implements VoiceNotesPlayerRepository {
  final VoiceNotePlayerLocalService voiceNotePlayerLocalService;

  VoiceNotePlayerRepositoryImpl({@required this.voiceNotePlayerLocalService});
  @override
  Future<Either<Failure, Unit>> pause() async {
    return _performActionOnPlayer(
      () => voiceNotePlayerLocalService.pause(),
    );
  }

  @override
  Future<Either<Failure, Unit>> play({
    String fileToPlay,
    Codec codec,
    int numChannels,
    int smapleRate,
    ui.VoidCallback onCompleted,
  }) async {
    return _performActionOnPlayer(
      () => voiceNotePlayerLocalService.play(
        fileToPlay: fileToPlay,
        codec: codec,
        numChannels: numChannels,
        smapleRate: smapleRate,
        onCompleted: onCompleted,
      ),
    );
  }

  @override
  Future<Either<Failure, Unit>> stop() async {
    return _performActionOnPlayer(
      () => voiceNotePlayerLocalService.stop(),
    );
  }

  @override
  Future<Either<Failure, Unit>> cancel({String audioFileToDelete}) async {
    return _performActionOnPlayer(
      () => voiceNotePlayerLocalService.cancel(
        fileToDelete: audioFileToDelete,
      ),
    );
  }

  @override
  Future<Either<Failure, Stream<PlayerStats>>> getPlayerStats() async {
    return _performActionOnPlayer(
      () => voiceNotePlayerLocalService.getPlayerStats(),
    );
  }

  /// common helper function for assisting in performing operations on the player
  Future<Either<Failure, T>> _performActionOnPlayer<T>(
      Future<T> Function() actionCallback) async {
    try {
      final result = await actionCallback();
      return Right(result);
    } on PlayBackException {
      return Left(PlaybackFailure());
    }
  }
}
