import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/session-manager.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-option-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-option.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/questionnaire.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/success-atempt-questionnaire.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';

abstract class AttemptQuestionnaireRemoteService {
  Future<SuccessAtemptQuestionnaire> attemptQuestionnaire({
    @required Questionnaire questionnaire,
    @required RxMap<Question, dynamic> questionToAnswerMap,
    @required RxMap<Question, QuestionOption> questionToScaleMap,
  });
}

class AttemptQuestionnaireRemoteServiceImpl
    implements AttemptQuestionnaireRemoteService {
  final http.Client client;

  AttemptQuestionnaireRemoteServiceImpl({
    @required this.client,
  });
  @override
  Future<SuccessAtemptQuestionnaire> attemptQuestionnaire({
    Questionnaire questionnaire,
    RxMap<Question, dynamic> questionToAnswerMap,
    RxMap<Question, QuestionOption> questionToScaleMap,
  }) async {
    final header = await SessionManager.getHeader();
    final requestBody = _buildRequestBody(
      questionnaire,
      questionToAnswerMap,
      questionToScaleMap,
    );
    final response = await client.post(
      Uri.parse(APIRoute.attemptQuestions),
      headers: header,
      body: requestBody,
    );
    await SessionManager.setHeader(
      header: response.headers,
    );
    if (response.statusCode == 200) {
      return const SuccessAtemptQuestionnaire();
    } else {
      throw ServerException();
    }
  }

  String _buildRequestBody(
    Questionnaire questionnaire,
    RxMap<Question, dynamic> questionToAnswerMap,
    RxMap<Question, QuestionOption> questionToScaleMap,
  ) {
    final List<Map> body = [];
    for (final question in questionnaire.questionVO) {
      if (question.questionType == 'SINGLE_CHOICE') {
        // Request body type for Single Choice Type Questions
        body.add(
          {
            "question": {
              "id": question.id,
            },
            "additionalInformation": "",
            "optionChosen": [
              (questionToAnswerMap[question] as QuestionOptionModel).toJson(),
            ],
          },
        );
      } else {
        // Request body type for RatingScale Type questions
        final double rating = (questionToAnswerMap[question] as num).toDouble();
        body.add(
          {
            "question": {
              "id": question.id,
            },
            "additionalInformation": "rating: $rating",
            "optionChosen": [
              {
                "RatingScale":
                    ((questionToScaleMap[question] as QuestionOptionModel)
                            .additionalInformation[0] as RatingScaleModel)
                        .toJson(),
              },
            ],
          },
        );
      }
    }
    return jsonEncode(body);
  }
}
