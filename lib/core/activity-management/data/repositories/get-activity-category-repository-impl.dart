// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/recommendation.dart';
import '../../domain/repositories/get-category-activities-repository.dart';
import '../models/recommendation-category-model.dart';
import '../sources/get-category-activites-remote-data-source.dart';

class GetCategoryActivitiesRepositoryImpl
    implements GetCategoryActivitiesRepository {
  final GetCategoryActivitiesRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  GetCategoryActivitiesRepositoryImpl({
    @required this.remoteDataSource,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, List<Recommendation>>> getActivities({
    RecommendationCategoryModel category,
  }) async {
    return baseRepository(
      () => remoteDataSource.getActivities(
        category: category,
      ),
    );
  }
}
