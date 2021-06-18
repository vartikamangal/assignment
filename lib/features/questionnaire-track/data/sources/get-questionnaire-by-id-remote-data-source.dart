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
import '../models/questionnaire-model.dart';

abstract class GetQuestionnaireByIdRemoteDataSource {
  Future<QuestionnaireModel> getQuestionnaireById({
    @required String id,
  });
}

class GetQuestionnaireByIdRemoteDataSourceImpl
    implements GetQuestionnaireByIdRemoteDataSource {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  GetQuestionnaireByIdRemoteDataSourceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<QuestionnaireModel> getQuestionnaireById({String id}) async {
    final response = await client.get(
      uri: "${APIRoute.getQuestionnaire}/$id",
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return QuestionnaireModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
