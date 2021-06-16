import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../entities/request-data.dart';
import '../entities/user-data.dart';
import '../../../error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, RequestData>> requestLogin({
    @required bool isNewLogin,
  });
  Future<Either<Failure, Unit>> requestLogout();
  Future<Either<Failure, RequestData>> requestNewToken();
  Future<Either<Failure, bool>> checkIfAlreadyLoggedIn();
  Future<Either<Failure, UserData>> getUserDetails();
}
