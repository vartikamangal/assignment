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
import '../models/questionnaire-model.dart';

abstract class GetQuestionnaireByIdRemoteDataSource {
  Future<QuestionnaireModel> getQuestionnaireById({
    @required String id,
  });
}

class GetQuestionnaireByIdRemoteDataSourceImpl
    implements GetQuestionnaireByIdRemoteDataSource {
  final http.Client client;

  GetQuestionnaireByIdRemoteDataSourceImpl({
    @required this.client,
  });
  @override
  Future<QuestionnaireModel> getQuestionnaireById({String id}) async {
    final uri = "${APIRoute.getQuestionnaire}/$id";
    final header = await SessionManager.getHeader();
    final response = await client.get(
      Uri.parse(uri),
      headers: header,
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      return QuestionnaireModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }
}
