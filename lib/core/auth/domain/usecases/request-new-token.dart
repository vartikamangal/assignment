import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../entities/oauth-data.dart';
import '../repositories/auth-repository.dart';

class RequestNewToken implements Usecase<OAuthData, NoParams> {
  final AuthRepository repository;

  RequestNewToken({
    @required this.repository,
  });
  @override
  Future<Either<Failure, OAuthData>> call(NoParams params) async {
    return repository.requestNewToken();
  }
}
