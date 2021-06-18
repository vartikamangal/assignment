// Dart imports:
import 'dart:convert';

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
import '../models/hub-status-model.dart';

abstract class GetHubStatusRemoteDataSource {
  Future<HubStatusModel> getHubStatus();
}

class GetHubStatusRemoteDataSourceImpl implements GetHubStatusRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  GetHubStatusRemoteDataSourceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<HubStatusModel> getHubStatus() async {
    final response = await client.get(
      uri: APIRoute.getHubUserStatus,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final jsonMap = jsonDecode(response.body) as Map;
    return HubStatusModel.fromJson(
      jsonMap as Map<String, dynamic>,
    );
  }
}
