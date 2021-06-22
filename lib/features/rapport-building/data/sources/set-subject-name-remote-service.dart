// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/subject-information-model.dart';

abstract class SetSubjectNameRemoteService {
  Future<SubjectInformationModel> setSubjectName({
    @required String name,
  });
}

class SetSubjectNameRemoteServiceImpl implements SetSubjectNameRemoteService {
  // Deivce ID is acting like s, Object sessionClientession id
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  SetSubjectNameRemoteServiceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<SubjectInformationModel> setSubjectName({
    String name,
  }) async {
    final response = await client.post(
      uri: APIRoute.setSubjectName,
      body: jsonEncode(
        {
          "nickName": name,
        },
      ),
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return SubjectInformationModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
