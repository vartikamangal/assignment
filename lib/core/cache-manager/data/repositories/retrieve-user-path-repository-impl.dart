// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/data/services/retrieve-user-path-local-data-source.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/retrieve-user-path-repository.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

class RetrieveUserPathRepositoryImpl implements RetrieveUserPathRepository {
  final RetrieveUserPathLocalDataSource localDataSource;

  RetrieveUserPathRepositoryImpl({
    @required this.localDataSource,
  });
  @override
  Future<Either<Failure, String>> retrievePath() async {
    try {
      final userPath = await localDataSource.retrievePath();
      return Right(
        userPath,
      );
    } on CacheException {
      return Left(
        CacheFailure(),
      );
    }
  }
}
