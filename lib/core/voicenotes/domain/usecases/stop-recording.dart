import 'package:flutter/cupertino.dart';
import '../../../error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../success/success-interface.dart';
import '../../../usecase/usecase.dart';
import '../repository/stop-recording-service.dart';

class StopRecording implements Usecase<Success, NoParams> {
  final StopRecordingService? service;

  StopRecording({
    required this.service,
  });
  @override
  Future<Either<Failure, Success>> call(NoParams params) async {
    return service!.stopRecording();
  }
}
