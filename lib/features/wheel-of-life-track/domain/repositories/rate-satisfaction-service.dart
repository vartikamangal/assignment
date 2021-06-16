// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../entities/satisfaction-ratings.dart';

abstract class RateSatisfactionService {
  Future<Either<Failure, Success>> rateSatisfactionService({
    @required SatisfactionRatings satisfactionRatings,
  });
}
