import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../error/failures.dart';
import 'call-if-network-connected.dart';
import 'handle-exception.dart';

class BaseRepository {
  final CallIfNetworkConnected callIfNetworkConnected;
  final HandleException handleException;

  BaseRepository({
    @required this.callIfNetworkConnected,
    @required this.handleException,
  });

  Future<Either<Failure, T>> call<T>(Future<T> Function() apiCall) async {
    return callIfNetworkConnected(
      () async => handleException(
        () async => apiCall(),
      ),
    );
  }
}
