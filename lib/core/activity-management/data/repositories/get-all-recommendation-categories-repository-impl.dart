// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/recommendation-category.dart';
import '../../domain/repositories/get-all-recommendation-catoegories-repository.dart';
import '../sources/get-all-recommendation-categories-remote-data-source.dart';

class GetAllRecommendationCategoriesRepositoryImpl
    implements GetAllRecommendationCategoriesRepository {
  final GetAllRecommendationCategoriesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetAllRecommendationCategoriesRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<RecommendationCategory>>>
      getAllCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final categories = await remoteDataSource.getAllCategories();
        return Right(categories);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
