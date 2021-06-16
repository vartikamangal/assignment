import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/post-onboarding-action.dart';
import '../repositories/get-action-with-action-status-repository.dart';

class GetActionWithActionStatus
    implements
        Usecase<List<PostOnboardingAction>, GetActionWithActionStatusParams> {
  final GetActionWithActionStatusRepository repository;

  GetActionWithActionStatus({
    @required this.repository,
  });
  @override
  Future<Either<Failure, List<PostOnboardingAction>>> call(
      GetActionWithActionStatusParams params) async {
    return repository.getActions(
      actionStatus: params.actionStatus,
    );
  }
}

class GetActionWithActionStatusParams extends Equatable {
  final String actionStatus;

  const GetActionWithActionStatusParams({
    @required this.actionStatus,
  });

  @override
  List<Object> get props => [actionStatus];

  @override
  bool get stringify => true;
}
