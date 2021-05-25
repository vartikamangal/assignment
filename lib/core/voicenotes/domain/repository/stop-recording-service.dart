import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';

abstract class StopRecordingService {
  Future<Either<Failure, Success>> stopRecording();
}
