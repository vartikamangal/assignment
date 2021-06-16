// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/feeling-duration.dart';
import '../repositories/get-available-feeling-duration-repository.dart';

class GetAvailableFeelingDuration
    implements Usecase<List<FeelingDuration>, NoParams> {
  final GetAvailableFeelingDurationRepository repository;

  GetAvailableFeelingDuration({
    @required this.repository,
  });
  @override
  Future<Either<Failure, List<FeelingDuration>>> call(NoParams params) async {
    return repository.getAvailableDurations();
  }
}
