// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/sources/rate-recommendation-flow-remote-service.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/repositories/rate-recommendation-flow-service.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';

class RateRecommendationFlowServiceImpl
    implements RateRecommendationFlowService {
  final RateRecommendationFlowRemoteService remoteService;
  final BaseRepository baseRepository;

  RateRecommendationFlowServiceImpl({
    @required this.remoteService,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, Unit>> rateRecommendation({
    FeedbackModel feedback,
  }) async {
    return baseRepository(
      () => remoteService.rateRecommendationFlow(
        feedback: feedback,
      ),
    );
  }
}
