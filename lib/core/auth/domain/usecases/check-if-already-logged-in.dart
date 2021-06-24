import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../repositories/auth-repository.dart';

class CheckIfAlreadyLoggedIn implements Usecase<bool, NoParams> {
  final AuthRepository repository;

  CheckIfAlreadyLoggedIn({
    @required this.repository,
  });
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return repository.checkIfAlreadyLoggedIn();
  }
}
