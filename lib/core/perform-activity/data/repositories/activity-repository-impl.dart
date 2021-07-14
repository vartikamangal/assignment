import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/activity_rating_model.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/sources/activity-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/repositories/activity-repository.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final BaseRepository baseRepository;
  final AcitivityRemoteDataSource remoteDataSource;

  ActivityRepositoryImpl({
    required this.baseRepository,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, Unit>?> rateActivity({
    required ActivityRatingModel feedback,
  }) async {
    return baseRepository(
      () => remoteDataSource.rateActivity(
        feedback: feedback,
      ),
    );
  }

  @override
  Future<Either<Failure, ActivityStatus>?> startActivity({
    required String recommendationId,
    required bool isInstantActivity,
  }) async {
    return baseRepository(
      () => remoteDataSource
          .startActivity(
            recommendationId: recommendationId,
            isInstantActivity: isInstantActivity,
          )
          .then((activityStatusModel) => activityStatusModel.toDomain()),
    );
  }

  @override
  Future<Either<Failure, ActivityStatus>?> updateActivityStatus({
    required String status,
    required int actionId,
  }) async {
    return baseRepository(
      () => remoteDataSource
          .updateActivityStatus(
            status: status,
            actionId: actionId,
          )
          .then((activityStatusModel) => activityStatusModel.toDomain()),
    );
  }
}
