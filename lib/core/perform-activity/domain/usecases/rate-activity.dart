// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/activity_rating_model.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/repositories/activity-repository.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class RateActivity implements Usecase<Unit, RateActivityParams> {
  final ActivityRepository repository;

  RateActivity({
    required this.repository,
  });
  @override
  Future<Either<Failure, Unit>?> call(RateActivityParams params) async {
    return repository.rateActivity(
      feedback: params.feedback,
    );
  }
}

class RateActivityParams extends Equatable {
  final ActivityRatingModel feedback;
  const RateActivityParams({
    required this.feedback,
  });
  @override
  List<Object> get props {
    return [feedback];
  }
}
