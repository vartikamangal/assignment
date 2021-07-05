import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../error/failures.dart';
import '../../../success/success-interface.dart';

abstract class StopRecordingService {
  Future<Either<Failure, Success>> stopRecording();
  Future<Either<Failure, Unit>> cancelRecording({
    required String? partialRecordingFileToDelete,
  });
}
