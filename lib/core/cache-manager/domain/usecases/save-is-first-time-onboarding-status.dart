import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../repositories/user-onboarding-status-repository.dart';

class SaveIsFirstTimeOnboardingStatus
    implements Usecase<Unit, SaveIsFirstTimeOnboardingStatusParams> {
  final UserOnboardingStatusRepository service;

  SaveIsFirstTimeOnboardingStatus({
    required this.service,
  });
  @override
  Future<Either<Failure, Unit>?> call(
      SaveIsFirstTimeOnboardingStatusParams params) async {
    return service.saveIsFirstTimeOnboardingStatus(
      onBoardingStatus: params.onBoardingStatus,
    );
  }
}

class SaveIsFirstTimeOnboardingStatusParams extends Equatable {
  final String onBoardingStatus;

  const SaveIsFirstTimeOnboardingStatusParams({
    required this.onBoardingStatus,
  });
  @override
  List<Object> get props => [onBoardingStatus];

  @override
  bool get stringify => true;
}
