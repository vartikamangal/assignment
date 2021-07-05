import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../entity/player-stats.dart';
import '../repository/voicenotes-player-repository.dart';

class GetPlayerStats implements Usecase<Stream<PlayerStats>, NoParams> {
  final VoiceNotesPlayerRepository voiceNotesPlayerRepository;

  GetPlayerStats({
    required this.voiceNotesPlayerRepository,
  });
  @override
  Future<Either<Failure, Stream<PlayerStats>>> call(
    NoParams params,
  ) async {
    return voiceNotesPlayerRepository.getPlayerStats();
  }
}
