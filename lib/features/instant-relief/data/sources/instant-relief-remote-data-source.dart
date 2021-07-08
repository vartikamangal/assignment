import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-activity-model.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/models/emergency-number-model.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/models/instant-relief-area-model.dart';

abstract class InstantReliefRemoteDataSource {
  Future<List<InstantReliefAreaModel>> getReliefAreas();
  Future<List<ActivityRecommendationModel>> getRecommendations({
    required String? instantLifeArea,
  });
  Future<List<EmergencyNumberModel>> fetchEmergencyNumbers();
}

class InstantReliefRemoteDataSourceImpl
    implements InstantReliefRemoteDataSource {
  final ApiClient? client;
  final ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  InstantReliefRemoteDataSourceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<EmergencyNumberModel>> fetchEmergencyNumbers() async {
    final response = await client!.get(
      uri: APIRoute.listEmergencyNumbers,
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    final emergencyContactsRaw = jsonDecode(response.body) as List;
    return emergencyContactsRaw
        .map((emergencyContact) => EmergencyNumberModel.fromJson(
            emergencyContact as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ActivityRecommendationModel>> getRecommendations({
    String? instantLifeArea,
  }) async {
    final response = await client!.post(
      uri: "${APIRoute.GET_INSTANT_RECOMMENDATIONS}${"/$instantLifeArea"}",
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    final rawRecommendations = jsonDecode(response.body) as List;
    return rawRecommendations
        .map((rawRecommendation) => ActivityRecommendationModel.fromJson(
              rawRecommendation as Map<String, dynamic>,
            ))
        .toList();
  }

  @override
  Future<List<InstantReliefAreaModel>> getReliefAreas() async {
    final response = await client!.get(
      uri: APIRoute.getInstantReliefAreas,
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    final instantReliefAreasRaw = jsonDecode(response.body) as List;
    return instantReliefAreasRaw
        .map((instantReliefArea) => InstantReliefAreaModel.fromJson(
              instantReliefArea as Map<String, dynamic>,
            ))
        .toList();
  }
}
