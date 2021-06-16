// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-activity.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/instant-relief-area.dart';

abstract class GetInstantReliefAreasRepository {
  Future<Either<Failure, List<InstantReliefArea>>> getReliefAreas();
  Future<Either<Failure, List<ActivityRecommendation>>> getRecommendations({
    @required String instantLifeArea,
  });
}
