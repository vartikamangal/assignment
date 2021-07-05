// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/repositories/instant-relief-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/instant-relief-area.dart';

class GetInstantReliefAreas
    implements Usecase<List<InstantReliefArea>, NoParams> {
  final InstantReliefRepository repository;

  GetInstantReliefAreas({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<InstantReliefArea>>?> call(
    NoParams params,
  ) async {
    return repository.getReliefAreas();
  }
}
