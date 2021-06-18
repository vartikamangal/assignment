// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:http/http.dart' as http;

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
  final http.Client client;

  SetSubjectNameRemoteServiceImpl({
    @required this.client,
  });
  @override
  Future<SubjectInformationModel> setSubjectName({
    String name,
  }) async {
    final header = await SessionManager.getHeader();
    final response = await client.post(
      Uri.parse(APIRoute.setSubjectName),
      headers: header,
      body: jsonEncode(
        {
          "nickName": name,
        },
      ),
    );
    await SessionManager.setHeader(header: response.headers);
    if (response.statusCode == 200) {
      final subjectInfo = SubjectInformationModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
      return subjectInfo;
    } else {
      throw ServerException();
    }
  }
}
