import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/data/models/app-duration-model.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/data/sources/app-duration-local-data-source.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/domain/entities/app-duration.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/domain/repository/app-duration-repository.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

class AppDurationRepositoryImpl implements AppDurationRepository {
  final AppDurationLocalDataSource localDataSource;

  AppDurationRepositoryImpl({
    @required this.localDataSource,
  });
  @override
  Future<Either<Failure, AppDuration>> getLastLogin() async {
    try {
      final appDuration = await localDataSource.getLastLogin();
      return Right(appDuration);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserDurationOnApp({
    AppDuration appDuration,
    bool isNewUser,
  }) async {
    try {
      final status = await localDataSource.updateUserDurationOnApp(
        appDuration: appDuration as AppDurationModel,
        isNewUser: isNewUser,
      );
      return Right(status);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
