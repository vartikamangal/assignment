// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/feeling-duration.dart';

class GetAvailableFeelingDuration
    implements Usecase<List<FeelingDuration>, NoParams> {
  final RapportBuildingRepository repository;

  GetAvailableFeelingDuration({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<FeelingDuration>>?> call(NoParams params) async {
    return repository.getAvailableDurations();
  }
}
