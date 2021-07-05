// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-activity-model.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

import '../../../../core/routes/api-routes/api-routes.dart';

abstract class GetRecommendationsByActionTimeRemoteDataSource {
  Future<List<ActivityRecommendationModel>> getRecommendations({
    required String? actionTime,
  });
}

class GetRecommendationsByActionTimeRemoteDataSourceImpl
    implements GetRecommendationsByActionTimeRemoteDataSource {
  final ApiClient? client;
  final ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  GetRecommendationsByActionTimeRemoteDataSourceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<ActivityRecommendationModel>> getRecommendations({
    String? actionTime,
  }) async {
    final response = await client!.get(
      uri: "${APIRoute.getRecommendationByActionTime}${"/$actionTime"}",
    );
    log(response.headers.toString());
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    final rawActivities = jsonDecode(response.body) as List;
    return rawActivities
        .map(
          (rawActivity) => ActivityRecommendationModel.fromJson(
            rawActivity as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
