import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../repositories/auth-repository.dart';
import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';

class RequestLogout implements Usecase<Unit, NoParams> {
  final AuthRepository repository;

  RequestLogout({
    @required this.repository,
  });
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return repository.requestLogout();
  }
}
