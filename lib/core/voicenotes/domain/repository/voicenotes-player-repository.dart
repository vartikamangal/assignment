import 'dart:ui' as ui;
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
import 'package:flutter_sound_lite/public/tau.dart';
import '../../../error/failures.dart';
import '../entity/player-stats.dart';

abstract class VoiceNotesPlayerRepository {
  /// Holds the contract for making play the passed in audio path
  Future<Either<Failure, Unit>> play({
    @required String fileToPlay,
    @required Codec codec,
    @required int numChannels,
    @required int smapleRate,
    @required ui.VoidCallback onCompleted,
  });

  /// Holds the contract for pausing the player, if playing
  Future<Either<Failure, Unit>> pause();

  /// Holds the contract for stopping the player if playing
  Future<Either<Failure, Unit>> stop();

  /// Holds the contract for clearing the previously recorded file
  /// should be used when user didn't liked his voicenote and wants to record a new one
  Future<Either<Failure, Unit>> cancel({@required String audioFileToDelete});

  /// Holds the contract for getting current position and total duration of voicenote
  Future<Either<Failure, Stream<PlayerStats>>> getPlayerStats();
}
