import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../../../core/session-manager/session-manager.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
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
      headers: header as Map<String, String>,
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
