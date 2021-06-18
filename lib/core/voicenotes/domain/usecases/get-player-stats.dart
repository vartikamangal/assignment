import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/player-stats.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';

class GetPlayerStats implements Usecase<Stream<PlayerStats>, NoParams> {
  final VoiceNotesPlayerRepository voiceNotesPlayerRepository;

  GetPlayerStats({
    @required this.voiceNotesPlayerRepository,
  });
  @override
  Future<Either<Failure, Stream<PlayerStats>>> call(
    NoParams params,
  ) async {
    return voiceNotesPlayerRepository.getPlayerStats();
  }
}
