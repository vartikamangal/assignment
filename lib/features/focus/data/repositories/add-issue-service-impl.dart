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
import '../../domain/repositories/add-issue-service.dart';
import '../sources/add-issue-remote-service.dart';

class AddIssueServiceImpl implements AddIssueService {
  final AddIssueRemoteService remoteService;
  final NetworkInfo networkInfo;

  AddIssueServiceImpl({
    @required this.remoteService,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, Success>> setTarget({Issue issue}) async {
    if (await networkInfo.isConnected) {
      try {
        final setIssueStatus = await remoteService.addIssue(issue: issue);
        return Right(setIssueStatus);
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
