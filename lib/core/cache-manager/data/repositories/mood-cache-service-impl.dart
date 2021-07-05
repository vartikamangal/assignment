import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../../repository/base-repository-impl.dart';
import '../../domain/entities/cached-mood.dart';
import '../../domain/repositories/mood-cache-service.dart';
import '../models/cached-mood-model.dart';
import '../services/mood-cache-local-service.dart';

class MoodCacheServiceImpl implements MoodCacheService {
  final MoodCacheLocalService localService;
  final BaseRepository baseRepository;

  MoodCacheServiceImpl({
    required this.localService,
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, Unit>?> cacheMood({
    CachedMood? mood,
  }) async {
    return baseRepository(
      () => localService.cacheMood(
        cachedMoodModel: mood as CachedMoodModel,
      ),
    );
  }

  @override
  Future<Either<Failure, CachedMoodModel>?> getCacheMood() async {
    return baseRepository(
      () => localService.getCachedMood(),
    );
  }
}
