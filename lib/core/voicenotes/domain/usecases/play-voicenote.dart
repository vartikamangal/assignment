import 'dart:ui' as ui;

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';

class PlayVoiceNote implements Usecase<Unit, PlayVoiceNoteParams> {
  final VoiceNotesPlayerRepository voiceNotesPlayerRepository;

  PlayVoiceNote({@required this.voiceNotesPlayerRepository});
  @override
  Future<Either<Failure, Unit>> call(PlayVoiceNoteParams params) async {
    return voiceNotesPlayerRepository.play(
      fileToPlay: params.fileToPlay,
      codec: params.codec,
      numChannels: params.numChannels,
      smapleRate: params.smapleRate,
      onCompleted: params.onCompleted,
    );
  }
}

class PlayVoiceNoteParams extends Equatable {
  final String fileToPlay;
  final Codec codec;
  final int numChannels;
  final int smapleRate;
  final ui.VoidCallback onCompleted;

  const PlayVoiceNoteParams({
    @required this.fileToPlay,
    @required this.codec,
    @required this.numChannels,
    @required this.smapleRate,
    @required this.onCompleted,
  });

  @override
  List<Object> get props {
    return [
      fileToPlay,
      codec,
      numChannels,
      smapleRate,
      onCompleted,
    ];
  }
}
