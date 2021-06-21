// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/issue-model.dart';

abstract class GetIssueRemoteDataSource {
  Future<List<IssueModel>> getIssues();
}

class GetIssueRemoteDataSourceImpl implements GetIssueRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  GetIssueRemoteDataSourceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<List<IssueModel>> getIssues() async {
    final response = await client.get(
      uri: APIRoute.getAllIssues,
    );
    SessionManager.setHeader(
      header: response.headers,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    final rawIssues = jsonDecode(response.body) as List;
    return rawIssues
        .map(
          (rawIssue) => IssueModel.fromJson(rawIssue as Map<String, dynamic>),
        )
        .toList();
  }
}
