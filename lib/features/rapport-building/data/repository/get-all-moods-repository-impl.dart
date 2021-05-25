import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/mood.dart';
import '../../domain/repositories/get-all-moods-repository.dart';
import '../sources/get-all-moods-remote-data-source.dart';

class GetAllMoodsRepositoryImpl implements GetAllMoodsRepository {
  final GetAllMoodsRemoteDataSource source;
  final NetworkInfo networkInfo;

  GetAllMoodsRepositoryImpl({
    @required this.source,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Mood>>> getAllMoods() async {
    if (await networkInfo.isConnected) {
      try {
        final moods = await source.getMoods();
        return Right(moods);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
