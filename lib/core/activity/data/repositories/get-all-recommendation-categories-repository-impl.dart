// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/recommendation-category.dart';
import '../../domain/repositories/get-all-recommendation-catoegories-repository.dart';
import '../sources/get-all-recommendation-categories-remote-data-source.dart';

class GetAllRecommendationCategoriesRepositoryImpl
    implements GetAllRecommendationCategoriesRepository {
  final GetAllRecommendationCategoriesRemoteDataSource? remoteDataSource;
  final BaseRepository baseRepository;

  GetAllRecommendationCategoriesRepositoryImpl({
    required this.remoteDataSource,
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, List<RecommendationCategory>>?>
      getAllCategories() async {
    return baseRepository(
      () => remoteDataSource!.getAllCategories(),
    );
  }
}
