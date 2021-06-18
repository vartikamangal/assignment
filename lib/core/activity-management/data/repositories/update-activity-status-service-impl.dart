// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/activity-status.dart';
import '../../domain/repositories/update-activity-status-service.dart';
import '../sources/update-activity-status-remote-sevice.dart';

class UpdateActivityStatusServiceImpl implements UpdateActivityStatusService {
  final UpdateActivityStatusRemoteService remoteService;
  final BaseRepository baseRepository;

  UpdateActivityStatusServiceImpl({
    @required this.remoteService,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, ActivityStatus>> updateStatus({
    String status,
    int actionId,
  }) async {
    return baseRepository(
      () => remoteService.modifyStatus(
        status: status,
        actionId: actionId,
      ),
    );
  }
}
