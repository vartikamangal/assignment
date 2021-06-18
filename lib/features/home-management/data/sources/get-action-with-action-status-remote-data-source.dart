import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/post-onboparding-action-model.dart';

abstract class GetActionWithActionStatusRemoteDataSource {
  Future<List<PostOnboardingActionModel>> getAction({
    @required String actionStatus,
  });
}

class GetActionWithActionStatusRemoteDataSourceImpl
    implements GetActionWithActionStatusRemoteDataSource {
  final http.Client client;

  GetActionWithActionStatusRemoteDataSourceImpl({
    @required this.client,
  });
  @override
  Future<List<PostOnboardingActionModel>> getAction({
    String actionStatus,
  }) async {
    final _uri = Uri.parse(
      "${APIRoute.getActionWithActionStatus}${"/$actionStatus"}",
    );
    final _headers = await SessionManager.getHeader();
    final response = await client.get(
      _uri,
      headers: _headers,
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      final actionsRaw = jsonDecode(response.body) as List;
      return actionsRaw
          .map(
            (actionRaw) => PostOnboardingActionModel.fromJson(
              actionRaw as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      log('problem in fetching actions with action-status');
      log(response.body);
      throw ServerException();
    }
  }
}
