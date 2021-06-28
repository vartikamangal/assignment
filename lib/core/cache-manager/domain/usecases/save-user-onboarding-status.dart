// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/user-onboarding-status-repository.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class SaveUserOnboardingStatus
    implements Usecase<Unit, SaveUserOnboardingStatusParams> {
  final UserOnboardingStatusRepository service;

  SaveUserOnboardingStatus({
    @required this.service,
  });
  @override
  Future<Either<Failure, Unit>> call(
      SaveUserOnboardingStatusParams params) async {
    return service.saveStatus(
      onBoardingStatus: params.status,
    );
  }
}

class SaveUserOnboardingStatusParams extends Equatable {
  final String status;
  const SaveUserOnboardingStatusParams({
    @required this.status,
  });
  @override
  List<Object> get props => [
        status,
      ];
}
