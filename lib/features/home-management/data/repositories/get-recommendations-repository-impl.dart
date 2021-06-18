// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-activity.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../../../features/home-management/data/sources/get-recommendations-by-action-time-remote-data-source.dart';
import '../../../../features/home-management/domain/repositories/get-recommendations-by-action-time-repository.dart';

class GetRecommendationsByActionTimeRepositoryRepositoryImpl
    implements GetRecommendationsByActionTimeRepository {
  final GetRecommendationsByActionTimeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetRecommendationsByActionTimeRepositoryRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<ActivityRecommendation>>> getRecommendations({
    String actionTime,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final recommendations = await remoteDataSource.getRecommendations(
          actionTime: actionTime,
        );
        return Right(
          recommendations,
        );
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    } else {
      return Left(
        ServerFailure(),
      );
    }
  }
}
