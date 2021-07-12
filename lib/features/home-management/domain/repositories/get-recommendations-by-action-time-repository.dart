// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

abstract class GetRecommendationsByActionTimeRepository {
  Future<Either<Failure, List<Activity>>?> getRecommendations({
    required String actionTime,
  });
}
