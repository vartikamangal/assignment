// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/instant-relief-area.dart';
import '../repositories/get-instant-relief-areas-repository.dart';

class GetInstantReliefAreas
    implements Usecase<List<InstantReliefArea>, NoParams> {
  final GetInstantReliefAreasRepository repository;

  GetInstantReliefAreas({
    @required this.repository,
  });
  @override
  Future<Either<Failure, List<InstantReliefArea>>> call(
    NoParams params,
  ) async {
    return repository.getReliefAreas();
  }
}
