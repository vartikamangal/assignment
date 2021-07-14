import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';

import '../../../../core/error/failures.dart';

abstract class AddWeeklyCategoryService {
  Future<Either<Failure, Unit>?> addWeeklyCategory({
    required int? weekNumber,
    required RecommendationCategory category,
  });

  Future<Either<Failure, Unit>?> addWeeklyActivity({
    required String category,
    required String? recommendationId,
  });
}
