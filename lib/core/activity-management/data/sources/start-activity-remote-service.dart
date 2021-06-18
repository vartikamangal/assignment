// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/activity-status-model.dart';

abstract class StartActivityRemoteService {
  Future<ActivityStatusModel> startActivity({
    @required String recommendationId,
    @required bool isInstantActivity,
  });
}

class StartActivityRemoteServiceImpl implements StartActivityRemoteService {
  final http.Client client;

  StartActivityRemoteServiceImpl({
    @required this.client,
  });
  @override
  Future<ActivityStatusModel> startActivity({
    String recommendationId,
    bool isInstantActivity,
  }) async {
    final uri = isInstantActivity
        ? "${APIRoute.startInstantActivity}/$recommendationId/start"
        : "${APIRoute.getRecommendationById}/$recommendationId/start";
    final header = await SessionManager.getHeader();
    final response = await client.get(
      Uri.parse(uri),
      headers: header,
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    log(response.body);
    log(response.headers.toString());
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
