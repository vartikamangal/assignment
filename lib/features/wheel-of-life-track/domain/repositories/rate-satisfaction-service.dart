import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../entities/satisfaction-ratings.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';

abstract class RateSatisfactionService {
  Future<Either<Failure, Success>> rateSatisfactionService({
    @required SatisfactionRatings satisfactionRatings,
  });
}
