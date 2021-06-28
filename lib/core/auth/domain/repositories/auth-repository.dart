import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../entities/oauth-data.dart';
import '../entities/user-data.dart';

abstract class AuthRepository {
  Future<Either<Failure, OAuthData>> oauthLogin();
  Future<Either<Failure, OAuthData>> oauthSignup();
  Future<Either<Failure, Unit>> requestLogout();
  Future<Either<Failure, OAuthData>> requestNewToken();
  Future<Either<Failure, bool>> checkIfAuthenticated();
  Future<Either<Failure, UserData>> getUserDetails();
}
