import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';

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
