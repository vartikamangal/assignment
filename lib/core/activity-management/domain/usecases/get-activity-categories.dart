// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/recommendation-category-model.dart';
import '../entities/recommendation.dart';
import '../repositories/get-category-activities-repository.dart';

class GetCategoryActivities
    implements Usecase<List<Recommendation>, GetCategoryActivitiesParams> {
  final GetCategoryActivitiesRepository repository;

  GetCategoryActivities({
    @required this.repository,
  });
  @override
  Future<Either<Failure, List<Recommendation>>> call(
      GetCategoryActivitiesParams params) {
    return repository.getActivities(
      category: params.category,
    );
  }
}

class GetCategoryActivitiesParams extends Equatable {
  final RecommendationCategoryModel category;

  const GetCategoryActivitiesParams({
    @required this.category,
  });
  @override
  List<Object> get props => [category];
}
