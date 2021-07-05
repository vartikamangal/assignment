import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../repositories/auth-repository.dart';

class CheckIfAuthenticated implements Usecase<bool, NoParams> {
  final AuthRepository repository;

  CheckIfAuthenticated({
    required this.repository,
  });
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return repository.checkIfAuthenticated();
  }
}
