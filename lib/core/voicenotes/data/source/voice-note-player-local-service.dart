import 'dart:developer';
import 'dart:ui' as ui;
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import '../../../error/exceptions.dart';
import '../../../file-manager/file-manager.dart';
import '../model/player-stats-model.dart';

abstract class VoiceNotePlayerLocalService {
  /// Holds the contract for playing passed in audio file
  /// throws [PlayBackException] in case of any uncertainities
  Future<Unit> play({
    @required String fileToPlay,
    @required Codec codec,
    @required int numChannels,
    @required int smapleRate,
    @required ui.VoidCallback onCompleted,
  });

  /// Holds the contract for pausing the player, if playing
  /// throws [PlayBackException] in case of any uncertainities
  Future<Unit> pause();

  /// Holds the contract for stopping the player
  /// throws [PlayBackException] in case of any uncertainities
  Future<Unit> stop();

  /// Holds the contract for stopping the player and clearing out data of present rcording session
  /// throws [PlayBackException] in case of any uncertainities
  Future<Unit> cancel({
    @required String fileToDelete,
  });

  /// Holds the contract for getting status of curreently played voicenote file
  /// throws [PlayBackException] in case of any uncertainities
  Future<Stream<PlayerStatsModel>> getPlayerStats();
}

/// Implementation with actual 3rd party library
class VoiceNotePlayerLocalServiceImpl implements VoiceNotePlayerLocalService {
  final FlutterSoundPlayer player;
  final FileUtils fileUtils;

  VoiceNotePlayerLocalServiceImpl({
    @required this.player,
    @required this.fileUtils,
  });
  @override
  Future<Unit> pause() async {
    return _operateOnRecorderService(
      () => player.pausePlayer(),
    );
  }

  @override
  Future<Unit> play({
    String fileToPlay,
    Codec codec,
    int numChannels,
    int smapleRate,
    ui.VoidCallback onCompleted,
  }) async {
    return _operateOnRecorderService(
      () async {
        /// Necessary to set this first
        /// Without it the progress wouldn't be displayed
        await player.setSubscriptionDuration(const Duration(milliseconds: 100));
        await player.startPlayer(
          fromURI: fileToPlay,
          codec: codec,
          numChannels: numChannels,
          sampleRate: smapleRate,
          whenFinished: onCompleted,
        );
        return null;
      },
    );
  }

  @override
  Future<Unit> stop() async {
    return _operateOnRecorderService(
      () => player.stopPlayer(),
    );
  }

  @override
  Future<Unit> cancel({String fileToDelete}) async {
    return _operateOnRecorderService(() async {
      await player.stopPlayer();
      await fileUtils.deleteFile(fileToDelete);
    });
  }

  @override
  Future<Stream<PlayerStatsModel>> getPlayerStats() async {
    try {
      final result = player.onProgress.map(
        (event) {
          print(event.position);
          return PlayerStatsModel(
            totalLength: event.duration,
            currentPosition: event.position,
          );
        },
      );
      return result;
    } catch (e) {
      log(e.toString());
      throw PlayBackException();
    }
  }

  Future<Unit> _operateOnRecorderService(
      Future<void> Function() serviceCallback) async {
    try {
      await serviceCallback();
      return Future.value(unit);
    } catch (e) {
      log(e.toString());
      throw PlayBackException();
    }
  }
}
