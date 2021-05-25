import '../../../../core/error/exceptions.dart';
import '../../../../core/platform/network_info.dart';
import '../sources/get-issues-remote-data-source.dart';
import '../../domain/entities/issue.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/get-issues-repository.dart';
import 'package:flutter/foundation.dart';

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
