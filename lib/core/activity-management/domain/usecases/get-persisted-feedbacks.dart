import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../entities/recommendation-input.dart';
import '../repositories/persist-recommendation-feedback-service.dart';
import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';

class GetPersistedFeedbacks
    implements Usecase<List<RecommendationInput>, NoParams> {
  final RecommendationFeedbackService service;

  GetPersistedFeedbacks({
    @required this.service,
  });
  @override
  Future<Either<Failure, List<RecommendationInput>>> call(
      NoParams params) async {
    return service.getpersistedFeedbacks();
  }
}
