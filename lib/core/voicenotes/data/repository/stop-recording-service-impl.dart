import 'package:flutter/cupertino.dart';
import '../../../error/exceptions.dart';
import '../../../success/success-interface.dart';
import '../../../error/failures.dart';
import 'package:dartz/dartz.dart';
import '../source/stop-recording-local-service.dart';
import '../../domain/entity/recording-stopped.dart';
import '../../domain/repository/stop-recording-service.dart';

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

  @override
  Future<Either<Failure, Unit>> cancelRecording({
    String partialRecordingFileToDelete,
  }) async {
    try {
      final result = await localService.cancelRecording(
        partialRecordingFileToDelete: partialRecordingFileToDelete,
      );
      return Right(
        result,
      );
    } on VoiceNoteExceptionOperationException {
      return Left(
        VoiceNoteFailure(),
      );
    }
  }
}
