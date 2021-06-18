// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/issue.dart';
import '../../domain/repositories/get-issues-repository.dart';
import '../sources/get-issues-remote-data-source.dart';

class GetIssuesRepositoryImpl implements GetIssuesRepository {
  final GetIssueRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  GetIssuesRepositoryImpl({
    @required this.remoteDataSource,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, List<Issue>>> getIssues() async {
    return baseRepository(
      () => remoteDataSource.getIssues(),
    );
  }
}
