// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/repositories/activity-repository.dart';

// Project imports:
import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../entities/activity-status.dart';

class StartActivity implements Usecase<ActivityStatus, StartAcitvityParams> {
  final ActivityRepository repository;

  StartActivity({
    required this.repository,
  });
  @override
  Future<Either<Failure, ActivityStatus>?> call(
      StartAcitvityParams params) async {
    return repository.startActivity(
      recommendationId: params.recommendationId,
      isInstantActivity: params.isInstantActivity,
    );
  }
}

class StartAcitvityParams extends Equatable {
  final String recommendationId;
  final bool isInstantActivity;

  const StartAcitvityParams({
    required this.recommendationId,
    required this.isInstantActivity,
  });
  @override
  List<Object?> get props => [recommendationId];
}
