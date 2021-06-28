import 'package:flutter/cupertino.dart';
import '../../../error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../usecase/usecase.dart';
import '../repository/voicenotes-player-repository.dart';

class StopPlayingVoiceNote implements Usecase<Unit, NoParams> {
  final VoiceNotesPlayerRepository voiceNotesPlayerRepository;

  StopPlayingVoiceNote({@required this.voiceNotesPlayerRepository});
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return voiceNotesPlayerRepository.stop();
  }
}
