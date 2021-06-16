import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/activity-management/data/models/recommendation-category-model.dart';
import '../../../../core/error/failures.dart';

abstract class AddWeeklyCategoryService {
  Future<Either<Failure, Unit>> addWeeklyCategory({
    @required int weekNumber,
    @required RecommendationCategoryModel category,
  });

  Future<Either<Failure, Unit>> addWeeklyActivity({
    @required String category,
    @required String recommendationId,
  });
}
