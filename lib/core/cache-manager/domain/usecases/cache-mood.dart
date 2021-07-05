import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../../data/models/cached-mood-model.dart';
import '../repositories/mood-cache-service.dart';

class CacheMood implements Usecase<Unit, CacheMoodParams> {
  final MoodCacheService service;

  CacheMood({
    required this.service,
  });
  @override
  Future<Either<Failure, Unit>?> call(CacheMoodParams params) async {
    return service.cacheMood(mood: params.mood);
  }
}

class CacheMoodParams extends Equatable {
  final CachedMoodModel mood;
  const CacheMoodParams({
    required this.mood,
  });

  @override
  List<Object> get props => [mood];
}
