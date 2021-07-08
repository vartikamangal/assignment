import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';

abstract class AcitivityRemoteDataSource {
  Future<Unit> rateActivity({
    required FeedbackModel feedback,
  });
  Future<ActivityStatusModel> startActivity({
    required String recommendationId,
    required bool isInstantActivity,
  });
  Future<ActivityStatusModel> updateActivityStatus({
    required String status,
    required int actionId,
  });
}

class AcitivityRemoteDataSourceImpl implements AcitivityRemoteDataSource {
  final ApiClient apiClient;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  AcitivityRemoteDataSourceImpl({
    required this.apiClient,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<Unit> rateActivity({
    required FeedbackModel feedback,
  }) async {
    final body = jsonEncode(feedback.toJson());
    final response = await apiClient.post(
      uri: APIRoute.rateActivityFeedback,
      body: body,
    );
    throwExceptionIfResponseError(
      statusCode: response.statusCode,
    );
    return unit;
  }

  @override
  Future<ActivityStatusModel> startActivity({
    required String recommendationId,
    required bool isInstantActivity,
  }) async {
    final uri = isInstantActivity
        ? "${APIRoute.startInstantActivity}/$recommendationId/start"
        : "${APIRoute.getRecommendationById}/$recommendationId/start";
    final response = await apiClient.get(
      uri: uri,
    );
    throwExceptionIfResponseError(
      statusCode: response.statusCode,
    );
    final rawActivityStatus = jsonDecode(response.body) as Map;
    return ActivityStatusModel.fromJson(
      rawActivityStatus as Map<String, dynamic>,
    );
  }

  @override
  Future<ActivityStatusModel> updateActivityStatus({
    required String status,
    required int actionId,
  }) async {
    final response = await apiClient.get(
      uri:
          "${APIRoute.updateActionStatus}/$actionId/status/${status.toUpperCase()}",
    );
    throwExceptionIfResponseError(
      statusCode: response.statusCode,
    );
    final rawActivityStatus = jsonDecode(response.body) as Map;
    return ActivityStatusModel.fromJson(
      rawActivityStatus as Map<String, dynamic>,
    );
  }
}
