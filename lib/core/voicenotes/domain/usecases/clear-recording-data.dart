import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../repository/voicenotes-player-repository.dart';

class ClearRecordingData implements Usecase<Unit, ClearRecordingDataPrams> {
  final VoiceNotesPlayerRepository voiceNotesPlayerRepository;

  ClearRecordingData({
    @required this.voiceNotesPlayerRepository,
  });
  @override
  Future<Either<Failure, Unit>> call(ClearRecordingDataPrams params) async {
    return voiceNotesPlayerRepository.cancel(
      audioFileToDelete: params.fileToDelete,
    );
  }
}

class ClearRecordingDataPrams extends Equatable {
  final String fileToDelete;

  const ClearRecordingDataPrams({
    @required this.fileToDelete,
  });
  @override
  List<Object> get props => [fileToDelete];
}
