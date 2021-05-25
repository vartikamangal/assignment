import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/instant-relief-area.dart';
import '../../domain/repositories/get-instant-relief-areas-repository.dart';
import '../sources/get-instant-relief-areas-remote-data-source.dart';

class GetInstantReliefAreasRepositoryImpl
    implements GetInstantReliefAreasRepository {
  final GetInstantReliefAreasRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetInstantReliefAreasRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<InstantReliefArea>>> getReliefAreas() async {
    if (await networkInfo.isConnected) {
      try {
        final reliefAreas = await remoteDataSource.getReliefAreas();
        return Right(reliefAreas);
      } on ServerException {
        return Left(DeviceOfflineFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
