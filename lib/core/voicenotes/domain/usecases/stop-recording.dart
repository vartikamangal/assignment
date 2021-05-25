import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/stop-recording-service.dart';

class StopRecording implements Usecase<Success, NoParams> {
  final StopRecordingService service;

  StopRecording({
    @required this.service,
  });
  @override
  Future<Either<Failure, Success>> call(NoParams params) async {
    return service.stopRecording();
  }
}
