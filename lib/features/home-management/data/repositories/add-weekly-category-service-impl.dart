import 'package:dartz/dartz.dart';

import '../../../../core/activity/data/models/recommendation-category-model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/repository/base-repository-impl.dart';
import '../../domain/repositories/add-weekly-category-service.dart';
import '../sources/add-weekly-category-remote-service.dart';

class AddWeeklyCategoryServiceImpl implements AddWeeklyCategoryService {
  final AddWeeklyCategoryRemoteService? remoteService;
  final BaseRepository baseRepository;

  AddWeeklyCategoryServiceImpl({
    required this.remoteService,
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, Unit>?> addWeeklyCategory({
    int? weekNumber,
    RecommendationCategoryModel? category,
  }) async {
    return baseRepository(
      () => remoteService!.addWeeklyCategory(
        weekNumber: weekNumber,
        category: category,
      ),
    );
  }

  @override
  Future<Either<Failure, Unit>?> addWeeklyActivity({
    String? category,
    String? recommendationId,
  }) async {
    return baseRepository(
      () => remoteService!.addWeeklyActivity(
        category: category,
        recomendationId: recommendationId,
      ),
    );
  }
}
