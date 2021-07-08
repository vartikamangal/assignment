// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-activity.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/repositories/get-recommendations-by-action-time-repository.dart';

class GetRecommendationsByActionTime
    implements
        Usecase<List<ActivityRecommendation>,
            GetRecommendationsByActionTimeParams> {
  final GetRecommendationsByActionTimeRepository repository;

  GetRecommendationsByActionTime({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<ActivityRecommendation>>?> call(
      GetRecommendationsByActionTimeParams params) async {
    return repository.getRecommendations(
      actionTime: params.actionTime,
    );
  }
}

class GetRecommendationsByActionTimeParams extends Equatable {
  final String actionTime;

  const GetRecommendationsByActionTimeParams({
    required this.actionTime,
  });
  @override
  List<Object> get props => [
        actionTime,
      ];
}
