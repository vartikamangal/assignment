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

abstract class UpdateActivityStatusRemoteService {
  Future<ActivityStatusModel> modifyStatus({
    @required String status,
    @required int actionId,
  });
}

class UpdateActivityStatusRemoteServiceImpl
    implements UpdateActivityStatusRemoteService {
  final http.Client client;

  UpdateActivityStatusRemoteServiceImpl({
    @required this.client,
  });
  @override
  Future<ActivityStatusModel> modifyStatus({
    String status,
    int actionId,
  }) async {
    final uri =
        "${APIRoute.updateActionStatus}/$actionId/status/${status.toUpperCase()}";
    log(uri);
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
