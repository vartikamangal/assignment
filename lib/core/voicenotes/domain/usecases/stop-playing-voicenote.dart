import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';

class StopPlayingVoiceNote implements Usecase<Unit, NoParams> {
  final VoiceNotesPlayerRepository voiceNotesPlayerRepository;

  StopPlayingVoiceNote({@required this.voiceNotesPlayerRepository});
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return voiceNotesPlayerRepository.stop();
  }
}
