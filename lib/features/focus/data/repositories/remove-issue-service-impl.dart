import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/error/exceptions.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../../../core/success/success-interface.dart';
import '../sources/remove-issue-remote-service.dart';
import '../../domain/entities/issue.dart';
import '../../domain/repositories/remove-issue-service.dart';

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
