import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/rating-scale.dart';

abstract class GetRatingScaleRepository {
  Future<Either<Failure, RatingScale>> getRatingScale();
}
