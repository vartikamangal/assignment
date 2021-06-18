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
import '../../domain/entities/add-issue-success.dart';
import '../../domain/entities/issue.dart';
import '../models/issue-model.dart';

abstract class AddIssueRemoteService {
  Future<AddIssueSuccess> addIssue({@required Issue issue});
}

class AddIssueRemoteServiceImpl implements AddIssueRemoteService {
  final http.Client client;

  AddIssueRemoteServiceImpl({
    @required this.client,
  });
  @override
  Future<AddIssueSuccess> addIssue({Issue issue}) async {
    final header = await SessionManager.getHeader();

    final response = await client.post(
      Uri.parse(APIRoute.addFocus),
      headers: header,
      body: jsonEncode((issue as IssueModel).toJson()),
    );
    SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      return AddIssueSuccess();
    } else {
      throw ServerException();
    }
  }
}
