import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../data/models/cached-mood-model.dart';

abstract class MoodCacheService {
  Future<Either<Failure, Unit>?> cacheMood({
    required CachedMoodModel mood,
  });
  Future<Either<Failure, CachedMoodModel>?> getCacheMood();
}
