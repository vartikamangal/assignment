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
import '../models/hub-status-model.dart';

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
