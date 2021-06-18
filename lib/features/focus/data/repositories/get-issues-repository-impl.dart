// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/issue.dart';
import '../../domain/repositories/get-issues-repository.dart';
import '../sources/get-issues-remote-data-source.dart';

class GetIssuesRepositoryImpl implements GetIssuesRepository {
  final GetIssueRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetIssuesRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Issue>>> getIssues() async {
    if (await networkInfo.isConnected) {
      try {
        final issues = await remoteDataSource.getIssues();
        return Right(issues);
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
