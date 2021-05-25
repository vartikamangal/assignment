import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/recommendation-category.dart';

abstract class GetAllRecommendationCategoriesRepository {
  Future<Either<Failure, List<RecommendationCategory>>> getAllCategories();
}
