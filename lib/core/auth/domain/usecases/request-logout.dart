import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../repositories/auth-repository.dart';

class RequestLogout implements Usecase<Unit, NoParams> {
  final AuthRepository repository;

  RequestLogout({
    required this.repository,
  });
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return repository.requestLogout();
  }
}
