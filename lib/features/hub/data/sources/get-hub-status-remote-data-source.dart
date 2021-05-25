import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/session-manager.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/hub-status-model.dart';
import 'package:http/http.dart' as http;

abstract class GetHubStatusRemoteDataSource {
  Future<HubStatusModel> getHubStatus();
}

class GetHubStatusRemoteDataSourceImpl implements GetHubStatusRemoteDataSource {
  final http.Client remoteClient;

  GetHubStatusRemoteDataSourceImpl({
    @required this.remoteClient,
  });
  @override
  Future<HubStatusModel> getHubStatus() async {
    final header = await SessionManager.getHeader();
    final response = await remoteClient.get(
      Uri.parse(APIRoute.getHubUserStatus),
      headers: header,
    );
    await SessionManager.setHeader(header: response.headers);
    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body) as Map;
      return HubStatusModel.fromJson(
        jsonMap as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }
}
