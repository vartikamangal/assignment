import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/features/path/domain/repositories/update-activity-status-service.dart';

class UpdateActivityStatus
    implements Usecase<ActivityStatus, UpdateActivityStatusParams> {
  final UpdateActivityStatusService service;

  UpdateActivityStatus({
    @required this.service,
  });
  @override
  Future<Either<Failure, ActivityStatus>> call(
      UpdateActivityStatusParams params) async {
    return service.updateStatus(
      status: params.status,
      actionId: params.actionId,
    );
  }
}

class UpdateActivityStatusParams extends Equatable {
  final String status;
  final int actionId;

  const UpdateActivityStatusParams({
    @required this.status,
    @required this.actionId,
  });
  @override
  List<Object> get props => [status];
}
