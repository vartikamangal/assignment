import 'package:flutter/cupertino.dart';
import '../services/mood-cache-local-service.dart';
import '../../domain/entities/cached-mood.dart';
import '../models/cached-mood-model.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/mood-cache-service.dart';
import '../../../error/exceptions.dart';
import '../../../error/failures.dart';

class MoodCacheServiceImpl implements MoodCacheService {
  final MoodCacheLocalService localService;

  MoodCacheServiceImpl({
    @required this.localService,
  });
  @override
  Future<Either<Failure, Unit>> cacheMood({
    CachedMood mood,
  }) async {
    try {
      final status = await localService.cacheMood(
        cachedMoodModel: mood as CachedMoodModel,
      );
      return Right(
        status,
      );
    } on CacheException {
      return Left(
        CacheFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, CachedMoodModel>> getCacheMood() async {
    try {
      final mood = await localService.getCachedMood();
      return Right(
        mood,
      );
    } on CacheException {
      return Left(
        CacheFailure(),
      );
    }
  }
}
