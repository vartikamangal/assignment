import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/recommendation-category.dart';
import '../repositories/get-all-recommendation-catoegories-repository.dart';

class GetAllRecommendationCategories
    implements Usecase<List<RecommendationCategory>, NoParams> {
  final GetAllRecommendationCategoriesRepository repository;

  GetAllRecommendationCategories({
    @required this.repository,
  });
  @override
  Future<Either<Failure, List<RecommendationCategory>>> call(
      NoParams params) async {
    return repository.getAllCategories();
  }
}
