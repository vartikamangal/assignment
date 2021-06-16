import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/source/get-recorder-stats-local-data-source.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/get-recorder-stats-repository.dart';

class GetRecorderStatsRepositoryImpl implements GetRecorderStatsRepository {
  final GetRecorderStatsLocalDataSource localDataSource;

  GetRecorderStatsRepositoryImpl({
    @required this.localDataSource,
  });
  @override
  Future<Either<Failure, Stream<RecordingDisposition>>> getDetails() async {
    try {
      final result = await localDataSource.getDetails();
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
