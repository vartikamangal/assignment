// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/recommendation.dart';
import '../../domain/repositories/get-category-activities-repository.dart';
import '../models/recommendation-category-model.dart';
import '../sources/get-category-activites-remote-data-source.dart';

class GetCategoryActivitiesRepositoryImpl
    implements GetCategoryActivitiesRepository {
  final GetCategoryActivitiesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetCategoryActivitiesRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Recommendation>>> getActivities({
    RecommendationCategoryModel category,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final activites = await remoteDataSource.getActivities(
          category: category,
        );
        return Right(activites);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
