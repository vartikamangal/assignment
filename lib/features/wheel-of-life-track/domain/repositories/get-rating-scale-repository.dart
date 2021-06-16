// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/rating-scale.dart';

abstract class GetRatingScaleRepository {
  Future<Either<Failure, RatingScale>> getRatingScale();
}
