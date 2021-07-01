import 'package:flutter/cupertino.dart';
import '../../../error/exceptions.dart';
import '../../../error/failures.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:dartz/dartz.dart';
import '../source/get-recorder-stats-local-data-source.dart';
import '../../domain/repository/get-recorder-stats-repository.dart';

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
