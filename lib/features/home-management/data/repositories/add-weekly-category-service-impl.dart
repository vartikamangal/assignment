import 'package:flutter/cupertino.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/activity-management/data/models/recommendation-category-model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/platform/network_info.dart';
import '../sources/add-weekly-category-remote-service.dart';
import '../../domain/repositories/add-weekly-category-service.dart';

class AddWeeklyCategoryServiceImpl implements AddWeeklyCategoryService {
  final AddWeeklyCategoryRemoteService remoteService;
  final NetworkInfo networkInfo;

  AddWeeklyCategoryServiceImpl({
    @required this.remoteService,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> addWeeklyCategory({
    int weekNumber,
    RecommendationCategoryModel category,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final status = await remoteService.addWeeklyCategory(
          weekNumber: weekNumber,
          category: category,
        );
        return Right(
          status,
        );
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    } else {
      return Left(
        DeviceOfflineFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> addWeeklyActivity({
    String category,
    String recommendationId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final status = await remoteService.addWeeklyActivity(
          category: category,
          recomendationId: recommendationId,
        );
        return Right(
          status,
        );
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    } else {
      return Left(
        DeviceOfflineFailure(),
      );
    }
  }
}
