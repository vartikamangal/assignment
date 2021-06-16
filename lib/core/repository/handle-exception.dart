import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

/// base exception handler for every remote-repository-impl in project
/// added [AuthFailure] because it will be of no effect in the non-tokened requests
class HandleException {
  Future<Either<Failure, T>> call<T>(Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();
      return Right(result);
    } on PlatformException catch (e) {
      return Left(
        AuthFailure(
          title: e.code,
          details: e.message,
        ),
      );
    } on AuthException {
      return const Left(
        AuthFailure(
          title: 'Authentication error',
          details: "Seems like you aren't logged in",
        ),
      );
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
