import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/add-issue-success.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue-removed-success.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue.dart';

abstract class FocusRemoteDataSource {
  Future<AddIssueSuccess> addIssue({required Issue? issue});
  Future<List<IssueModel>> getIssues();
  Future<IssueRemovedSuccess> removeIssue({required Issue? issue});
}

class FocusRemoteDataSourceImpl implements FocusRemoteDataSource {
  final ApiClient? client;
  final ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  FocusRemoteDataSourceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<AddIssueSuccess> addIssue({Issue? issue}) async {
    final response = await client!.post(
      uri: APIRoute.addFocus,
      body: jsonEncode((issue as IssueModel).toJson()),
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    return AddIssueSuccess();
  }

  @override
  Future<List<IssueModel>> getIssues() async {
    final response = await client!.get(
      uri: APIRoute.getAllIssues,
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    final rawIssues = jsonDecode(response.body) as List;
    return rawIssues
        .map(
          (rawIssue) => IssueModel.fromJson(rawIssue as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<IssueRemovedSuccess> removeIssue({Issue? issue}) async {
    final response = await client!.post(
      uri: APIRoute.deleteFocus,
      body: jsonEncode((issue as IssueModel).toJson()),
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    return IssueRemovedSuccess();
  }
}
