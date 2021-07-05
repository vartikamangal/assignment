import 'package:dartz/dartz.dart';

import '../../../error/exceptions.dart';
import '../../../error/failures.dart';
import '../../domain/entities/app-duration.dart';
import '../../domain/repository/app-duration-repository.dart';
import '../models/app-duration-model.dart';
import '../sources/app-duration-local-data-source.dart';

class AppDurationRepositoryImpl implements AppDurationRepository {
  final AppDurationLocalDataSource? localDataSource;

  AppDurationRepositoryImpl({
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, AppDuration>> getLastLogin() async {
    try {
      final appDuration = await localDataSource!.getLastLogin();
      return Right(appDuration);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserDurationOnApp({
    AppDuration? appDuration,
    bool? isNewUser,
  }) async {
    try {
      final status = await localDataSource!.updateUserDurationOnApp(
        appDuration: appDuration as AppDurationModel?,
        isNewUser: isNewUser,
      );
      return Right(status);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
