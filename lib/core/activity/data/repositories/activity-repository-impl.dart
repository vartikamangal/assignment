import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/activity-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/activity-repository.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
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
    required FeedbackModel feedback,
  }) async {
    return baseRepository(
      () => remoteDataSource.rateActivity(feedback: feedback),
    );
  }

  @override
  Future<Either<Failure, ActivityStatus>?> startActivity({
    required String recommendationId,
    required bool isInstantActivity,
  }) async {
    return baseRepository(
      () => remoteDataSource.startActivity(
        recommendationId: recommendationId,
        isInstantActivity: isInstantActivity,
      ),
    );
  }

  @override
  Future<Either<Failure, ActivityStatus>?> updateActivityStatus({
    required String status,
    required int actionId,
  }) async {
    return baseRepository(
      () => remoteDataSource.updateActivityStatus(
        status: status,
        actionId: actionId,
      ),
    );
  }
}
