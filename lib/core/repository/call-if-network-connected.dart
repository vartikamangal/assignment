import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../error/failures.dart';
import '../platform/network_info.dart';

class CallIfNetworkConnected {
  final NetworkInfo networkInfo;

  CallIfNetworkConnected({
    @required this.networkInfo,
  });

  Future<Either<Failure, T>> call<T>(
      Future<Either<Failure, T>> Function() x) async {
    if (await networkInfo.isConnected) {
      final result = await x();
      return result;
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
