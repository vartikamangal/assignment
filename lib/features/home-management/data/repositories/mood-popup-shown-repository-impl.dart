import 'package:flutter/cupertino.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../sources/mood-popup-shown-local-data-source.dart';
import '../../domain/repositories/mood-popup-shown-repository.dart';

class MoodPopupShownRepositoryImpl implements MoodPopupShownRepository {
  final MoodPopupShownLocalDataSource localDataSource;

  MoodPopupShownRepositoryImpl({
    @required this.localDataSource,
  });
  @override
  Future<Either<Failure, bool>> getMoodPopupShownStatus() async {
    try {
      final result = await localDataSource.getMoodPopupShownStatus();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> toogleIsMoodPopupShownState() async {
    try {
      final result = await localDataSource.toogleIsMoodPopupShownState();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
