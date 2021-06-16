import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../data/models/cached-mood-model.dart';
import '../../../error/failures.dart';

abstract class MoodCacheService {
  Future<Either<Failure, Unit>> cacheMood({
    @required CachedMoodModel mood,
  });
  Future<Either<Failure, CachedMoodModel>> getCacheMood();
}
