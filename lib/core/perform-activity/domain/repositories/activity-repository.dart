import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/activity_rating_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/perform-activity/domain/entities/activity-status.dart';

abstract class ActivityRepository {
  /// Is responsible for the rating the acitivity at the end of Acitivty completion
  Future<Either<Failure, Unit>?> rateActivity({
    required ActivityRatingModel feedback,
  });

  /// Updates the status of ongoing acitivty on activity completed/quitted...
  Future<Either<Failure, ActivityStatus>?> updateActivityStatus({
    required String status,
    required int actionId,
  });

  /// Starts the activity and returns the [ActivityStatus] object
  Future<Either<Failure, ActivityStatus>?> startActivity({
    required String recommendationId,
    required bool isInstantActivity,
  });
}
