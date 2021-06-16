import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../entities/request-data.dart';
import '../repositories/auth-repository.dart';
import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';

class RequestNewToken implements Usecase<RequestData, NoParams> {
  final AuthRepository repository;

  RequestNewToken({
    @required this.repository,
  });
  @override
  Future<Either<Failure, RequestData>> call(NoParams params) async {
    return repository.requestNewToken();
  }
}
