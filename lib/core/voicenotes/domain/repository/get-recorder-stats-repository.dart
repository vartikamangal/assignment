import 'package:dartz/dartz.dart';
import 'package:flutter_sound/flutter_sound.dart';
import '../../../error/failures.dart';

abstract class GetRecorderStatsRepository {
  Future<Either<Failure, Stream<RecordingDisposition>?>> getDetails();
}
