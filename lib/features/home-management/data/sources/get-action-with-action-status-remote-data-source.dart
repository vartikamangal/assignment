import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../../core/data-source/api-client.dart';
import '../../../../core/data-source/throw-exception-if-response-error.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/post-onboparding-action-model.dart';

abstract class GetActionWithActionStatusRemoteDataSource {
  Future<List<PostOnboardingActionModel>> getAction({
    required String? actionStatus,
  });
}

class GetActionWithActionStatusRemoteDataSourceImpl
    implements GetActionWithActionStatusRemoteDataSource {
  final ApiClient? client;
  final ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  GetActionWithActionStatusRemoteDataSourceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<PostOnboardingActionModel>> getAction({
    String? actionStatus,
  }) async {
    final response = await client!.get(
      uri: "${APIRoute.getActionWithActionStatus}${"/$actionStatus"}",
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    final actionsRaw = jsonDecode(response.body) as List;
    return actionsRaw
        .map(
          (actionRaw) => PostOnboardingActionModel.fromJson(
            actionRaw as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
