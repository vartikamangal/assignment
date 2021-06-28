import 'package:flutter/cupertino.dart';
import '../../../error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../usecase/usecase.dart';
import '../repository/voicenotes-player-repository.dart';

class PauseVoiceNote implements Usecase<Unit, NoParams> {
  final VoiceNotesPlayerRepository voiceNotesPlayerRepository;

  PauseVoiceNote({@required this.voiceNotesPlayerRepository});
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return voiceNotesPlayerRepository.pause();
  }
}
