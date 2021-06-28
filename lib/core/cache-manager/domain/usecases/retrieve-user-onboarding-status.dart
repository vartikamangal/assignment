// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/user-onboarding-status-repository.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class RetrieveUserOnboardingStatus implements Usecase<String, NoParams> {
  final UserOnboardingStatusRepository service;

  RetrieveUserOnboardingStatus({
    @required this.service,
  });
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return service.fetchStatus();
  }
}
