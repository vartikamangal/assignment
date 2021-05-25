import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/life-area.dart';
import '../../domain/repositories/get-life-areas-repository.dart';
import '../sources/get-life-areas-remote-data-source.dart';

class GetLifeAreasRepositoryImpl implements GetLifeAreasRepository {
  final GetLifeAreasRemoteDataSource source;
  final NetworkInfo networkInfo;

  GetLifeAreasRepositoryImpl({
    @required this.source,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<LifeArea>>> getLifeAreas() async {
    if (await networkInfo.isConnected) {
      try {
        final areas = await source.getAreas();
        return Right(areas);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
