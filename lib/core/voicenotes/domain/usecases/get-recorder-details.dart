import 'package:dartz/dartz.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../repository/get-recorder-stats-repository.dart';

class GetRecorderDetails
    implements Usecase<Stream<RecordingDisposition>?, NoParams> {
  final GetRecorderStatsRepository repository;

  GetRecorderDetails({
    required this.repository,
  });
  @override
  Future<Either<Failure, Stream<RecordingDisposition>?>> call(
      NoParams params) async {
    return repository.getDetails();
  }
}
