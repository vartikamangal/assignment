// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Project imports:
import 'package:tatsam_app_experimental/core/activity/data/models/activity-model.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

import '../../../../core/routes/api-routes/api-routes.dart';

abstract class GetRecommendationsByActionTimeRemoteDataSource {
  Future<List<ActivityModel>> getRecommendations({
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
  Future<List<ActivityModel>> getRecommendations({
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
          (rawActivity) => ActivityModel.fromJson(
            rawActivity as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
