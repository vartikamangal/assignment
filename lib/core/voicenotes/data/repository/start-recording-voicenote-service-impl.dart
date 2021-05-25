import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/start-recording-voicenote-local-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/recording-started-status.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/start-recording-voicenote-service.dart';

class StartRecordingVoiceNoteServiceImpl
    implements StartRecordingVoiceNoteService {
  final StartRecordingVoiceNoteLocalService localService;

  StartRecordingVoiceNoteServiceImpl({
    @required this.localService,
  });
  @override
  Future<Either<Failure, Success>> startRecodring({
    String filePath,
    Codec codec,
  }) async {
    try {
      await localService.startRecording(
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
