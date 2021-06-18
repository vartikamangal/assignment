// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../domain/entities/issue-removed-success.dart';
import '../../domain/entities/issue.dart';
import '../models/issue-model.dart';

abstract class RemoveIssueRemoteService {
  Future<IssueRemovedSuccess> removeIssue({@required Issue issue});
}

class RemoveIssueRemoteServiceImpl implements RemoveIssueRemoteService {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  RemoveIssueRemoteServiceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<IssueRemovedSuccess> removeIssue({Issue issue}) async {
    final response = await client.post(
      uri: APIRoute.deleteFocus,
      body: jsonEncode((issue as IssueModel).toJson()),
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return IssueRemovedSuccess();
  }
}
