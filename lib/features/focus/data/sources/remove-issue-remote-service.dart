// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/persistence-consts.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../../domain/entities/issue-removed-success.dart';
import '../../domain/entities/issue.dart';
import '../models/issue-model.dart';

abstract class RemoveIssueRemoteService {
  Future<IssueRemovedSuccess> removeIssue({@required Issue issue});
}

class RemoveIssueRemoteServiceImpl implements RemoveIssueRemoteService {
  final http.Client client;
  final Box sessionClient;

  RemoveIssueRemoteServiceImpl({
    @required this.client,
    @required this.sessionClient,
  });
  @override
  Future<IssueRemovedSuccess> removeIssue({Issue issue}) async {
    final header = await SessionManager.getHeader();
    final response = await client.post(
      Uri.parse(APIRoute.deleteFocus),
      headers: header,
      body: jsonEncode((issue as IssueModel).toJson()),
    );
    SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      final isRemoved = jsonDecode(response.body) as int;
      if (isRemoved == 1) {
        return IssueRemovedSuccess();
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
