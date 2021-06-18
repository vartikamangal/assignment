// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/sources/rate-recommendation-flow-remote-service.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/repositories/rate-recommendation-flow-service.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';

class RateRecommendationFlowServiceImpl
    implements RateRecommendationFlowService {
  final RateRecommendationFlowRemoteService remoteService;
  final NetworkInfo networkInfo;

  RateRecommendationFlowServiceImpl({
    @required this.remoteService,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> rateRecommendation({
    FeedbackModel feedback,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final feedbackStatusResponse =
            await remoteService.rateRecommendationFlow(
          feedback: feedback,
        );
        return Right(
          feedbackStatusResponse,
        );
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    } else {
      return Left(
        DeviceOfflineFailure(),
      );
    }
  }
}
