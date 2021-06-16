// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

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
  final BaseRepository baseRepository;

  RemoveIssueServiceImpl({
    @required this.remoteService,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, Success>> removeIssue({Issue issue}) async {
    return baseRepository(
      () => remoteService.removeIssue(issue: issue),
    );
  }
}
