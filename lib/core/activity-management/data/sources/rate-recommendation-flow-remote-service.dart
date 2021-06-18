// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/session-manager.dart';

abstract class RateRecommendationFlowRemoteService {
  Future<Unit> rateRecommendationFlow({
    @required FeedbackModel feedback,
  });
}

class RateRecommendationFlowRemoteServiceImpl
    implements RateRecommendationFlowRemoteService {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  RateRecommendationFlowRemoteServiceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<Unit> rateRecommendationFlow({
    FeedbackModel feedback,
  }) async {
    final body = jsonEncode(
      feedback.toJson(),
    );
    final response = await client.post(
      uri: APIRoute.rateActivityFeedback,
      body: body,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return unit;
  }
}
