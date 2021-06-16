// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../data/models/recommendation-category-model.dart';
import '../entities/recommendation.dart';

abstract class GetCategoryActivitiesRepository {
  Future<Either<Failure, List<Recommendation>>> getActivities({
    @required RecommendationCategoryModel category,
  });
}
