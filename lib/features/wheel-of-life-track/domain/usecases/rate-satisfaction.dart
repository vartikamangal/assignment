// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/life-area.dart';
import '../entities/rating-scale.dart';
import '../entities/satisfaction-rating-map-for-time-provision-scale.dart';
import '../entities/satisfaction-ratings.dart';
import '../repositories/rate-satisfaction-service.dart';

class RateSatisfaction extends Usecase<Success, RateSatisfactionParams> {
  final RateSatisfactionService service;

  RateSatisfaction({@required this.service});
  @override
  Future<Either<Failure, Success>> call(RateSatisfactionParams params) async {
    return service.rateSatisfactionService(satisfactionRatings: params.ratings);
  }
}

class RateSatisfactionParams extends Equatable {
  final SatisfactionRatings ratings;

  const RateSatisfactionParams({@required this.ratings});
  @override
  List<Object> get props => [ratings];
}
