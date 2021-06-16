// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../domain/entities/add-issue-success.dart';
import '../../domain/entities/issue.dart';
import '../models/issue-model.dart';

abstract class AddIssueRemoteService {
  Future<AddIssueSuccess> addIssue({@required Issue issue});
}

class AddIssueRemoteServiceImpl implements AddIssueRemoteService {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  AddIssueRemoteServiceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<AddIssueSuccess> addIssue({Issue issue}) async {
    final response = await client.post(
      uri: APIRoute.addFocus,
      body: jsonEncode((issue as IssueModel).toJson()),
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return AddIssueSuccess();
  }
}
