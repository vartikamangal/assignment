// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/repositories/path-operations-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/journey.dart';

class GetJourneyPathList implements Usecase<List<Journey>, NoParams> {
  final PathOperationsRepository repository;

  GetJourneyPathList({required this.repository});
  @override
  Future<Either<Failure, List<Journey>>?> call(NoParams params) async {
    return repository.getJourneyPaths();
  }
}
