// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/data/services/retrieve-user-path-local-data-source.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/retrieve-user-path-repository.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

class RetrieveUserPathRepositoryImpl implements RetrieveUserPathRepository {
  final RetrieveUserPathLocalDataSource localDataSource;
  final BaseRepository baseRepository;

  RetrieveUserPathRepositoryImpl({
    @required this.localDataSource,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, String>> retrievePath() async {
    return baseRepository(
      () => localDataSource.retrievePath(),
    );
  }
}
