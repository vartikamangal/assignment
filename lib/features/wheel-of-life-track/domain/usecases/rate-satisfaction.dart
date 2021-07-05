// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/repositories/wheel-of-life-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/satisfaction-ratings.dart';

class RateSatisfaction extends Usecase<Success, RateSatisfactionParams> {
  final WheelOfLifeRepository service;

  RateSatisfaction({required this.service});
  @override
  Future<Either<Failure, Success>?> call(RateSatisfactionParams params) async {
    return service.rateSatisfactionService(satisfactionRatings: params.ratings);
  }
}

class RateSatisfactionParams extends Equatable {
  final SatisfactionRatings ratings;

  const RateSatisfactionParams({required this.ratings});
  @override
  List<Object> get props => [ratings];
}
