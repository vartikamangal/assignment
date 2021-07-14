import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/features/view-all-content/data/sources/list-activities-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/page-request.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/page.dart';

import '../../domain/repository/list-activities-repository.dart';

class ListActivitiesRepositoryImpl implements ListActivitiesRepository {
  final BaseRepository baseRepository;
  final ListActivitiesRemoteDataSource listActivitiesRemoteDataSource;

  const ListActivitiesRepositoryImpl({
    required this.baseRepository,
    required this.listActivitiesRemoteDataSource,
  });
  @override
  Future<Either<Failure, Page<Activity>>> getAllRecommendations({
    required PageRequest pageRequest,
  }) async {
    return baseRepository(
      () => listActivitiesRemoteDataSource
          .listActivities(
            pageRequest: pageRequest,
          )
          .then((pageModel) => pageModel.toDomain()),
    );
  }
}
