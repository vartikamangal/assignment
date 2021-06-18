// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../domain/entities/issue.dart';
import '../../domain/repositories/add-issue-service.dart';
import '../sources/add-issue-remote-service.dart';

class AddIssueServiceImpl implements AddIssueService {
  final AddIssueRemoteService remoteService;
  final BaseRepository baseRepository;

  AddIssueServiceImpl({
    @required this.remoteService,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, Success>> setTarget({Issue issue}) async {
    return baseRepository(
      () => remoteService.addIssue(issue: issue),
    );
  }
}
