import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/features/path/domain/repositories/start-activity-service.dart';

class StartActivity implements Usecase<ActivityStatus, StartAcitvityParams> {
  final StartActivityService service;

  StartActivity({
    @required this.service,
  });
  @override
  Future<Either<Failure, ActivityStatus>> call(
      StartAcitvityParams params) async {
    return service.startActivity(
      recommendationId: params.recommendationId,
    );
  }
}

class StartAcitvityParams extends Equatable {
  final String recommendationId;

  const StartAcitvityParams({
    @required this.recommendationId,
  });
  @override
  List<Object> get props => [recommendationId];
}
