import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../repositories/save-user-onboarding-status-service.dart';

class CheckIfFirstTimeUser implements Usecase<bool, NoParams> {
  final SaveUserOnboardingStatusService service;

  CheckIfFirstTimeUser({
    @required this.service,
  });
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return service.checkIfFirstTimeUser();
  }
}
