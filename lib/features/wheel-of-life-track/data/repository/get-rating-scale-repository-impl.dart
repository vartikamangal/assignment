import 'package:flutter/cupertino.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/platform/network_info.dart';
import '../sources/get-rating-scale-remote-data-source.dart';
import '../../domain/entities/rating-scale.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/get-rating-scale-repository.dart';

class GetRatingScaleRepositoryImpl implements GetRatingScaleRepository {
  final GetRatingScaleRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetRatingScaleRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, RatingScale>> getRatingScale() async {
    if (await networkInfo.isConnected) {
      try {
        final ratingScale = await remoteDataSource.getRatingScale();
        return Right(ratingScale);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
