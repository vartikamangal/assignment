import 'package:flutter/cupertino.dart';
import '../repositories/user-onboarding-status-repository.dart';
import '../../../error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../usecase/usecase.dart';

class CheckIfFirstTimeUser implements Usecase<bool, NoParams> {
  final UserOnboardingStatusRepository service;

  CheckIfFirstTimeUser({
    @required this.service,
  });
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return service.checkIfFirstTimeUser();
  }
}
