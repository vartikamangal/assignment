import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../entities/life-areas-for-prioritization.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';

abstract class PrioritizeService {
  Future<Either<Failure, Success>> prioritize({
    @required LifeAreaForPrioritization lifeAreas,
  });
}
