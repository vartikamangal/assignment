// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

import '../../../../core/routes/api-routes/api-routes.dart';
import '../models/activity-status-model.dart';

abstract class StartActivityRemoteService {
  Future<ActivityStatusModel> startActivity({
    required String? recommendationId,
    required bool? isInstantActivity,
  });
}

class StartActivityRemoteServiceImpl implements StartActivityRemoteService {
  final ApiClient? client;
  final ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  StartActivityRemoteServiceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<ActivityStatusModel> startActivity({
    String? recommendationId,
    bool? isInstantActivity,
  }) async {
    final uri = isInstantActivity!
        ? "${APIRoute.startInstantActivity}/$recommendationId/start"
        : "${APIRoute.getRecommendationById}/$recommendationId/start";
    final response = await client!.get(
      uri: uri,
    );
    log(response.body);
    throwExceptionIfResponseError!(
      statusCode: response.statusCode,
    );
    final rawActivityStatus = jsonDecode(response.body) as Map;
    return ActivityStatusModel.fromJson(
      rawActivityStatus as Map<String, dynamic>,
    );
  }
}
