import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/activity-management/domain/entities/recommendation-activity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/get-instant-relief-areas-repository.dart';

class GetInstantRecommendations
    implements
        Usecase<List<ActivityRecommendation>, GetInstantRecommendationsParams> {
  final GetInstantReliefAreasRepository repository;

  GetInstantRecommendations({
    @required this.repository,
  });
  @override
  Future<Either<Failure, List<ActivityRecommendation>>> call(
      GetInstantRecommendationsParams params) async {
    return repository.getRecommendations(
      instantLifeArea: params.instantLifeArea,
    );
  }
}

class GetInstantRecommendationsParams extends Equatable {
  final String instantLifeArea;

  const GetInstantRecommendationsParams({
    @required this.instantLifeArea,
  });
  @override
  List<Object> get props => [
        instantLifeArea,
      ];
}
