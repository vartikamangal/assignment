// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-activity-model.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/instant-relief-area-model.dart';

abstract class GetInstantReliefAreasRemoteDataSource {
  Future<List<InstantReliefAreaModel>> getReliefAreas();
  Future<List<ActivityRecommendationModel>> getRecommendations({
    @required String instantLifeArea,
  });
}

class GetInstantReliefAreasRemoteDataSourceImpl
    implements GetInstantReliefAreasRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  GetInstantReliefAreasRemoteDataSourceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<InstantReliefAreaModel>> getReliefAreas() async {
    final response = await client.get(
      uri: APIRoute.getInstantReliefAreas,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final instantReliefAreasRaw = jsonDecode(response.body) as List;
    return instantReliefAreasRaw
        .map(
          (instantReliefArea) => InstantReliefAreaModel.fromJson(
              instantReliefArea as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<List<ActivityRecommendationModel>> getRecommendations({
    @required String instantLifeArea,
  }) async {
    final response = await client.post(
      uri: "${APIRoute.GET_INSTANT_RECOMMENDATIONS}${"/$instantLifeArea"}",
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final rawRecommendations = jsonDecode(response.body) as List;
    return rawRecommendations
        .map(
          (rawRecommendation) => ActivityRecommendationModel.fromJson(
            rawRecommendation as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
