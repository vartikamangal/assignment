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
import '../models/issue-model.dart';

abstract class GetIssueRemoteDataSource {
  Future<List<IssueModel>> getIssues();
}

class GetIssueRemoteDataSourceImpl implements GetIssueRemoteDataSource {
  final http.Client client;

  GetIssueRemoteDataSourceImpl({
    @required this.client,
  });
  @override
  Future<List<IssueModel>> getIssues() async {
    final header = await SessionManager.getHeader();
    final response = await client.get(
      Uri.parse(APIRoute.getAllIssues),
      headers: header,
    );
    SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      final rawIssues = jsonDecode(response.body) as List;
      return rawIssues
          .map(
            (rawIssue) => IssueModel.fromJson(rawIssue as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }
}
