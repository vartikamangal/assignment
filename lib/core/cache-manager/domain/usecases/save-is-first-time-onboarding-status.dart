import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../repositories/save-user-onboarding-status-service.dart';
import '../../../error/failures.dart';

import '../../../usecase/usecase.dart';

class SaveIsFirstTimeOnboardingStatus
    implements Usecase<Unit, SaveIsFirstTimeOnboardingStatusParams> {
  final SaveUserOnboardingStatusService service;

  SaveIsFirstTimeOnboardingStatus({
    @required this.service,
  });
  @override
  Future<Either<Failure, Unit>> call(
      SaveIsFirstTimeOnboardingStatusParams params) async {
    return service.saveIsFirstTimeOnboardingStatus(
      onBoardingStatus: params.onBoardingStatus,
    );
  }
}

class SaveIsFirstTimeOnboardingStatusParams extends Equatable {
  final String onBoardingStatus;

  const SaveIsFirstTimeOnboardingStatusParams({
    @required this.onBoardingStatus,
  });
  @override
  // TODO: implement props
  List<Object> get props => [onBoardingStatus];

  @override
  bool get stringify => true;
}
