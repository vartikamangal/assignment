import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../entities/request-data.dart';
import '../repositories/auth-repository.dart';
import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';

class RequestLogin implements Usecase<RequestData, RequestLoginParams> {
  final AuthRepository repository;

  RequestLogin({
    @required this.repository,
  });
  @override
  Future<Either<Failure, RequestData>> call(RequestLoginParams params) async {
    return repository.requestLogin(
      isNewLogin: params.isNewLogin,
    );
  }
}

class RequestLoginParams extends Equatable {
  final bool isNewLogin;
  const RequestLoginParams({
    @required this.isNewLogin,
  });

  @override
  List<Object> get props => [
        isNewLogin,
      ];
}
