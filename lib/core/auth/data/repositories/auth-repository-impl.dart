import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../error/failures.dart';
import '../../../platform/network_info.dart';
import '../../domain/entities/oauth-data.dart';
import '../../domain/entities/user-data.dart';
import '../../domain/repositories/auth-repository.dart';
import '../sources/auth-remote-service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteService remoteService;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    @required this.remoteService,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, bool>> checkIfAuthenticated() async {
    if (await networkInfo.isConnected) {
      try {
        final loginStatus = await remoteService.checkIfAuthenticated();
        return Right(loginStatus);
      } on PlatformException catch (e) {
        return Left(AuthFailure(title: e.code, details: e.message));
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }

  @override
  Future<Either<Failure, OAuthData>> oauthLogin({
    bool isNewLogin,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final loginStatus = await remoteService.oauthLogin();
        return Right(loginStatus);
      } on PlatformException catch (e) {
        return Left(
          AuthFailure(title: e.code, details: e.message),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> requestLogout() async {
    if (await networkInfo.isConnected) {
      try {
        final logoutStatus = await remoteService.requestLogout();
        return Right(logoutStatus);
      } on PlatformException catch (e) {
        return Left(
          AuthFailure(title: e.code, details: e.message),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }

  @override
  Future<Either<Failure, OAuthData>> requestNewToken() async {
    if (await networkInfo.isConnected) {
      try {
        final newRequestData = await remoteService.requestNewToken();
        return Right(newRequestData);
      } on PlatformException catch (e) {
        return Left(
          AuthFailure(title: e.code, details: e.message),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserData>> getUserDetails() async {
    if (await networkInfo.isConnected) {
      try {
        final userData = await remoteService.getUserDetails();
        return Right(userData);
      } on PlatformException catch (e) {
        return Left(
          AuthFailure(title: e.code, details: e.message),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }

  @override
  Future<Either<Failure, OAuthData>> oauthSignup() async {
    if (await networkInfo.isConnected) {
      try {
        final OAuthData = await remoteService.oauthSignup();
        return Right(OAuthData);
      } on PlatformException catch (e) {
        return Left(
          AuthFailure(title: e.code, details: e.message),
        );
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
