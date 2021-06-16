import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/home-management/data/sources/mood-popup-shown-local-data-source.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/repositories/mood-popup-shown-repository.dart';

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
