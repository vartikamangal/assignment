import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/get-recorder-stats-repository.dart';

class GetRecorderDetails
    implements Usecase<Stream<RecordingDisposition>, NoParams> {
  final GetRecorderStatsRepository repository;

  GetRecorderDetails({
    @required this.repository,
  });
  @override
  Future<Either<Failure, Stream<RecordingDisposition>>> call(
      NoParams params) async {
    return repository.getDetails();
  }
}
