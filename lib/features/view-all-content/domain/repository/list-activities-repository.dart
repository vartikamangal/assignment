import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/page-request.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/page.dart';

abstract class ListActivitiesRepository {
  Future<Either<Failure, Page<Activity>>> getAllRecommendations({
    required PageRequest pageRequest,
  });
}
