import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/stop-recording-local-service.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/recording-stopped.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/stop-recording-service.dart';

class StopRecordingServiceImpl implements StopRecordingService {
  final StopRecordingLocalService localService;

  StopRecordingServiceImpl({
    @required this.localService,
  });
  @override
  Future<Either<Failure, Success>> stopRecording() async {
    try {
      await localService.stopRecording();
      return const Right(
        RecordingStopped(status: 'Stoppped'),
      );
    } on VoiceNoteExceptionOperationException {
      return Left(
        VoiceNoteFailure(),
      );
    }
  }
}
