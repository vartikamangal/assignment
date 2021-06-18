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
  final http.Client client;

  RateRecommendationFlowRemoteServiceImpl({
    @required this.client,
  });
  @override
  Future<Unit> rateRecommendationFlow({
    FeedbackModel feedback,
  }) async {
    final body = jsonEncode(
      feedback.toJson(),
    );
    final header = await SessionManager.getHeader();
    final response = await client.post(
      Uri.parse(
        APIRoute.rateActivityFeedback,
      ),
      headers: header,
      body: body,
    );
    log(APIRoute.rateActivityFeedback);
    log(header.toString());
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }
}
