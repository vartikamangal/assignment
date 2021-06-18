// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../../../core/success/success-interface.dart';
import '../../domain/entities/issue.dart';
import '../../domain/repositories/remove-issue-service.dart';
import '../sources/remove-issue-remote-service.dart';

class RemoveIssueServiceImpl implements RemoveIssueService {
  final RemoveIssueRemoteService remoteService;
  final NetworkInfo networkInfo;

  RemoveIssueServiceImpl({
    @required this.remoteService,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, Success>> removeIssue({Issue issue}) async {
    if (await networkInfo.isConnected) {
      try {
        final issueRemoved = await remoteService.removeIssue(issue: issue);
        return Right(issueRemoved);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
