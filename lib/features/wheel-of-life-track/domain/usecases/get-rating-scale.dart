import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../repositories/get-rating-scale-repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/rating-scale.dart';

class GetRatingScale implements Usecase<RatingScale, NoParams> {
  final GetRatingScaleRepository repository;

  GetRatingScale({@required this.repository});
  @override
  Future<Either<Failure, RatingScale>> call(NoParams params) async {
    return repository.getRatingScale();
  }
}
