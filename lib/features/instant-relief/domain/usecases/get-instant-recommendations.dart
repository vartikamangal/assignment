import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/repositories/instant-relief-repository.dart';

import '../../../../core/activity/domain/entities/activity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class GetInstantRecommendations
    implements Usecase<List<Activity>, GetInstantRecommendationsParams> {
  final InstantReliefRepository repository;

  GetInstantRecommendations({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<Activity>>?> call(
      GetInstantRecommendationsParams params) async {
    return repository.getRecommendations(
      instantLifeArea: params.instantLifeArea,
    );
  }
}

class GetInstantRecommendationsParams extends Equatable {
  final String? instantLifeArea;

  const GetInstantRecommendationsParams({
    required this.instantLifeArea,
  });
  @override
  List<Object?> get props => [
        instantLifeArea,
      ];
}
