// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/repositories/activity-repository.dart';

// Project imports:
import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../entities/activity-status.dart';

class UpdateActivityStatus
    implements Usecase<ActivityStatus, UpdateActivityStatusParams> {
  final ActivityRepository repository;

  UpdateActivityStatus({
    required this.repository,
  });
  @override
  Future<Either<Failure, ActivityStatus>?> call(
      UpdateActivityStatusParams params) async {
    return repository.updateActivityStatus(
      status: params.status,
      actionId: params.actionId,
    );
  }
}

class UpdateActivityStatusParams extends Equatable {
  final String status;
  final int actionId;

  const UpdateActivityStatusParams({
    required this.status,
    required this.actionId,
  });
  @override
  List<Object> get props => [status];
}
