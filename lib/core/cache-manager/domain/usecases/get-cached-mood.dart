import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../entities/cached-mood.dart';
import '../repositories/mood-cache-service.dart';
import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';

class GetCachedMood implements Usecase<CachedMood, NoParams> {
  final MoodCacheService service;

  GetCachedMood({
    @required this.service,
  });
  @override
  Future<Either<Failure, CachedMood>> call(NoParams params) async {
    return service.getCacheMood();
  }
}
