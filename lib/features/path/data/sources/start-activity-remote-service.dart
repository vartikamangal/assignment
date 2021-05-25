import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/session-manager.dart';
import 'package:tatsam_app_experimental/features/path/data/models/activity-status-model.dart';
import 'package:http/http.dart' as http;

abstract class StartActivityRemoteService {
  Future<ActivityStatusModel> startActivity({
    @required String recommendationId,
  });
}

class StartActivityRemoteServiceImpl implements StartActivityRemoteService {
  final http.Client client;

  StartActivityRemoteServiceImpl({
    @required this.client,
  });
  @override
  Future<ActivityStatusModel> startActivity({String recommendationId}) async {
    final uri = "${APIRoute.getRecommendationById}/$recommendationId/start";
    final header = await SessionManager.getHeader();
    final response = await client.get(
      Uri.parse(uri),
      headers: header,
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      final rawActivityStatus = jsonDecode(response.body) as Map;
      return ActivityStatusModel.fromJson(
        rawActivityStatus as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }
}
