import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';

class PauseVoiceNote implements Usecase<Unit, NoParams> {
  final VoiceNotesPlayerRepository voiceNotesPlayerRepository;

  PauseVoiceNote({@required this.voiceNotesPlayerRepository});
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return voiceNotesPlayerRepository.pause();
  }
}
