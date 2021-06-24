import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/stop-recording-service.dart';

class CancelRecording implements Usecase<Unit, CancelRecordingParams> {
  final StopRecordingService service;

  CancelRecording({
    @required this.service,
  });
  @override
  Future<Either<Failure, Unit>> call(CancelRecordingParams params) async {
    return service.cancelRecording(
      partialRecordingFileToDelete: params.incompleteRecordedFileToDelete,
    );
  }
}

class CancelRecordingParams extends Equatable {
  final String incompleteRecordedFileToDelete;
  const CancelRecordingParams({
    @required this.incompleteRecordedFileToDelete,
  });

  @override
  List<Object> get props => [incompleteRecordedFileToDelete];

  @override
  bool get stringify => true;
}
