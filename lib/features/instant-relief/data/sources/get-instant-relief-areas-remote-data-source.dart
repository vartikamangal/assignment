// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-activity-model.dart';

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
  final http.Client client;

  GetInstantReliefAreasRemoteDataSourceImpl({
    @required this.client,
  });
  @override
  Future<List<InstantReliefAreaModel>> getReliefAreas() async {
    final headers = await SessionManager.getHeader();
    final response = await client.get(
      Uri.parse(APIRoute.getInstantReliefAreas),
      headers: headers,
    );
    SessionManager.setHeader(
      header: response.headers,
    );

    if (response.statusCode == 200) {
      final instantReliefAreasRaw = jsonDecode(response.body) as List;
      return instantReliefAreasRaw
          .map(
            (instantReliefArea) => InstantReliefAreaModel.fromJson(
                instantReliefArea as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ActivityRecommendationModel>> getRecommendations({
    @required String instantLifeArea,
  }) async {
    final uri = Uri.parse(
      "${APIRoute.GET_INSTANT_RECOMMENDATIONS}${"/$instantLifeArea"}",
    );
    final headers = await SessionManager.getHeader();
    final response = await client.post(
      uri,
      headers: headers,
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    log(uri.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final rawRecommendations = jsonDecode(response.body) as List;
      return rawRecommendations
          .map(
            (rawRecommendation) => ActivityRecommendationModel.fromJson(
              rawRecommendation as Map<String, dynamic>,
            ),
          )
          .toList();
    }
    if (response.statusCode == 401) {
      throw AuthException();
    } else {
      throw ServerException();
    }
  }
}
