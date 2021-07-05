// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/activity-status.dart';
import '../repositories/start-activity-service.dart';

class StartActivity implements Usecase<ActivityStatus, StartAcitvityParams> {
  final StartActivityService? service;

  StartActivity({
    required this.service,
  });
  @override
  Future<Either<Failure, ActivityStatus>?> call(
      StartAcitvityParams params) async {
    return service!.startActivity(
      recommendationId: params.recommendationId,
      isInstantActivity: params.isInstantActivity,
    );
  }
}

class StartAcitvityParams extends Equatable {
  final String? recommendationId;
  final bool isInstantActivity;

  const StartAcitvityParams({
    required this.recommendationId,
    required this.isInstantActivity,
  });
  @override
  List<Object?> get props => [recommendationId];
}
