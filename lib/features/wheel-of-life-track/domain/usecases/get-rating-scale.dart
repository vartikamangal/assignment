// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/rating-scale.dart';
import '../repositories/get-rating-scale-repository.dart';

class GetRatingScale implements Usecase<RatingScale, NoParams> {
  final GetRatingScaleRepository repository;

  GetRatingScale({@required this.repository});
  @override
  Future<Either<Failure, RatingScale>> call(NoParams params) async {
    return repository.getRatingScale();
  }
}
