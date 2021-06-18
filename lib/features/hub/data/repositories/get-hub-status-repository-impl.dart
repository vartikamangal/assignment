// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/hub-status.dart';
import '../../domain/repository/get-hub-status-repository.dart';
import '../sources/get-hub-status-remote-data-source.dart';

class GetHubStatusRepositoryImpl implements GetHubStatusRepository {
  final GetHubStatusRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetHubStatusRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, HubStatus>> getHubStatus() async {
    if (await networkInfo.isConnected) {
      try {
        final hubStats = await remoteDataSource.getHubStatus();
        return Right(hubStats);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
