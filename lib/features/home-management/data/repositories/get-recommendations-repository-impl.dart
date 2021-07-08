// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-activity.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

import '../../../../core/error/failures.dart';
import '../../../../features/home-management/data/sources/get-recommendations-by-action-time-remote-data-source.dart';
import '../../../../features/home-management/domain/repositories/get-recommendations-by-action-time-repository.dart';

class GetRecommendationsByActionTimeRepositoryRepositoryImpl
    implements GetRecommendationsByActionTimeRepository {
  final GetRecommendationsByActionTimeRemoteDataSource? remoteDataSource;
  final BaseRepository baseRepository;

  GetRecommendationsByActionTimeRepositoryRepositoryImpl({
    required this.remoteDataSource,
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, List<ActivityRecommendation>>?> getRecommendations({
    String? actionTime,
  }) async {
    return baseRepository(
      () => remoteDataSource!.getRecommendations(
        actionTime: actionTime,
      ),
    );
  }
}
