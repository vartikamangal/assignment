// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/recommendation.dart';

abstract class GetCategoryActivitiesRepository {
  Future<Either<Failure, List<Recommendation>>?> getActivities({
    required RecommendationCategory category,
  });
}
