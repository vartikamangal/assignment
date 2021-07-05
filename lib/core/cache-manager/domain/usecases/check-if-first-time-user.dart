import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../repositories/user-onboarding-status-repository.dart';

class CheckIfFirstTimeUser implements Usecase<bool, NoParams> {
  final UserOnboardingStatusRepository service;

  CheckIfFirstTimeUser({
    required this.service,
  });
  @override
  Future<Either<Failure, bool>?> call(NoParams params) async {
    return service.checkIfFirstTimeUser();
  }
}
