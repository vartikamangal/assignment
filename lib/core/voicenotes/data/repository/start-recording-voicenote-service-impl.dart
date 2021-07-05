import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import '../../../error/exceptions.dart';
import '../../../error/failures.dart';
import '../../../success/success-interface.dart';
import '../source/start-recording-voicenote-local-service.dart';
import '../../domain/entity/recording-started-status.dart';
import '../../domain/repository/start-recording-voicenote-service.dart';

class StartRecordingVoiceNoteServiceImpl
    implements StartRecordingVoiceNoteService {
  final StartRecordingVoiceNoteLocalService? localService;

  StartRecordingVoiceNoteServiceImpl({
    required this.localService,
  });
  @override
  Future<Either<Failure, Success>> startRecodring({
    String? filePath,
    Codec? codec,
  }) async {
    try {
      await localService!.startRecording(
        filePath: filePath,
        codec: codec,
      );
      return const Right(
        RecordingStarted(
          recordingStatus: 'Recording Started',
        ),
      );
    } on NotPermittedActionException {
      return Left(
        NotPermittedActionFailure(),
      );
    } on VoiceNoteExceptionOperationException {
      return Left(
        VoiceNoteFailure(),
      );
    }
  }
}
