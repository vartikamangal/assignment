// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Package imports:
import 'package:dartz/dartz.dart';
// Flutter imports:
import 'package:flutter/cupertino.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';

abstract class RateRecommendationFlowRemoteService {
  Future<Unit> rateRecommendationFlow({
    required FeedbackModel? feedback,
  });
}

class RateRecommendationFlowRemoteServiceImpl
    implements RateRecommendationFlowRemoteService {
  final ApiClient? client;
  final ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  RateRecommendationFlowRemoteServiceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<Unit> rateRecommendationFlow({
    FeedbackModel? feedback,
  }) async {
    final body = jsonEncode(
      feedback!.toJson(),
    );
    log(body);
    final response = await client!.post(
      uri: APIRoute.rateActivityFeedback,
      body: body,
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    return unit;
  }
}
