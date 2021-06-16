import 'package:flutter/cupertino.dart';
import '../repositories/auth-repository.dart';
import '../../../error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../usecase/usecase.dart';

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
