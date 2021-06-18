// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-activity-model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';

abstract class GetRecommendationsByActionTimeRemoteDataSource {
  Future<List<ActivityRecommendationModel>> getRecommendations({
    @required String actionTime,
  });
}

class GetRecommendationsByActionTimeRemoteDataSourceImpl
    implements GetRecommendationsByActionTimeRemoteDataSource {
  final http.Client remoteClient;

  GetRecommendationsByActionTimeRemoteDataSourceImpl({
    @required this.remoteClient,
  });
  @override
  Future<List<ActivityRecommendationModel>> getRecommendations({
    String actionTime,
  }) async {
    final _uri = Uri.parse(
      "${APIRoute.getRecommendationByActionTime}${"/$actionTime"}",
    );
    final headers = await SessionManager.getHeader();
    final response = await remoteClient.get(
      _uri,
      headers: headers,
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      final rawActivities = jsonDecode(response.body) as List;
      return rawActivities
          .map(
            (rawActivity) => ActivityRecommendationModel.fromJson(
              rawActivity as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      log(response.body);
      throw ServerException();
    }
  }
}
