// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/activity-status-model.dart';

abstract class UpdateActivityStatusRemoteService {
  Future<ActivityStatusModel> modifyStatus({
    @required String status,
    @required int actionId,
  });
}

class UpdateActivityStatusRemoteServiceImpl
    implements UpdateActivityStatusRemoteService {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  UpdateActivityStatusRemoteServiceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<ActivityStatusModel> modifyStatus({
    String status,
    int actionId,
  }) async {
    final response = await client.get(
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
