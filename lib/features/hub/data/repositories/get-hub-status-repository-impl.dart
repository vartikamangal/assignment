import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/features/hub/data/sources/get-hub-status-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/hub-status.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/hub/domain/repository/get-hub-status-repository.dart';

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
