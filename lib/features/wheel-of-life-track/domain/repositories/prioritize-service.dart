// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../entities/life-areas-for-prioritization.dart';

abstract class PrioritizeService {
  Future<Either<Failure, Success>> prioritize({
    @required LifeAreaForPrioritization lifeAreas,
  });
}
