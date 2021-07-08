import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class ActivityRepository {
  Future<Either<Failure, Unit>?> rateActivity({
    required FeedbackModel feedback,
  });
  Future<Either<Failure, ActivityStatus>?> updateActivityStatus({
    required String status,
    required int actionId,
  });

  Future<Either<Failure, ActivityStatus>?> startActivity({
    required String recommendationId,
    required bool isInstantActivity,
  });
}
