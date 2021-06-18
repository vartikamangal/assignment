import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../error/exceptions.dart';
import '../../../error/failures.dart';
import '../../../platform/network_info.dart';
import '../../domain/entities/request-data.dart';
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
  Future<Either<Failure, bool>> checkIfAlreadyLoggedIn() async {
    if (await networkInfo.isConnected) {
      try {
        final loginStatus = await remoteService.checkIfAlreadyLoggedIn();
        return Right(
          loginStatus,
        );
      } on PlatformException catch (e) {
        return Left(AuthFailure(
          reason: e.details.toString(),
          smallMessage: e.message,
          code: e.code,
        ));
      }
    } else {
      return Left(
        DeviceOfflineFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, RequestData>> requestLogin({
    bool isNewLogin,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final loginStatus = await remoteService.requestLogin(
          isNewLogin: isNewLogin,
        );
        return Right(
          loginStatus,
        );
      } on PlatformException catch (e) {
        return Left(AuthFailure(
          reason: e.details.toString(),
          smallMessage: e.message,
          code: e.code,
        ));
      }
    } else {
      return Left(
        DeviceOfflineFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> requestLogout() async {
    if (await networkInfo.isConnected) {
      try {
        final logoutStatus = await remoteService.requestLogout();
        return Right(
          logoutStatus,
        );
      } on PlatformException catch (e) {
        return Left(AuthFailure(
          reason: e.details.toString(),
          smallMessage: e.message,
          code: e.code,
        ));
      }
    } else {
      return Left(
        DeviceOfflineFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, RequestData>> requestNewToken() async {
    if (await networkInfo.isConnected) {
      try {
        final newRequestData = await remoteService.requestNewToken();
        return Right(
          newRequestData,
        );
      } on PlatformException catch (e) {
        return Left(
          AuthFailure(
            reason: e.details.toString(),
            smallMessage: e.message,
            code: e.code,
          ),
        );
      }
    } else {
      return Left(
        DeviceOfflineFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, UserData>> getUserDetails() {
    // TODO: implement getUserDetails
    throw UnimplementedError();
  }
}
