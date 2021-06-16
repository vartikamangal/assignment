import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';

abstract class StopRecordingService {
  Future<Either<Failure, Success>> stopRecording();
  Future<Either<Failure, Unit>> cancelRecording({
    @required String partialRecordingFileToDelete,
  });
}
