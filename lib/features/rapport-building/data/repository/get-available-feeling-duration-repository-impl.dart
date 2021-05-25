import 'package:flutter/cupertino.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/platform/network_info.dart';
import '../sources/get-available-feeling-duration-remote-data-source.dart';
import '../../domain/entities/feeling-duration.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/get-available-feeling-duration-repository.dart';

class GetAvailableFeelingDurationRepositoryImpl
    implements GetAvailableFeelingDurationRepository {
  final NetworkInfo networkInfo;
  final GetAvailableFeelingDurationRemoteDataSource remoteDataSource;

  GetAvailableFeelingDurationRepositoryImpl({
    @required this.networkInfo,
    @required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<FeelingDuration>>> getAvailableDurations() async {
    if (await networkInfo.isConnected) {
      try {
        final availableDurations =
            await remoteDataSource.getAvailableDurations();
        return Right(availableDurations);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
