// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/recommendation-category.dart';

abstract class GetAllRecommendationCategoriesRepository {
  Future<Either<Failure, List<RecommendationCategory>>> getAllCategories();
}
