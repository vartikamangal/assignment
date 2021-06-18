// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../../../wheel-of-life-track/data/models/rating-scale-model.dart';
import '../../domain/entities/question-option.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/questionnaire.dart';
import '../../domain/entities/success-atempt-questionnaire.dart';
import '../models/question-option-model.dart';

abstract class AttemptQuestionnaireRemoteService {
  Future<SuccessAtemptQuestionnaire> attemptQuestionnaire({
    @required Questionnaire questionnaire,
    @required RxMap<Question, dynamic> questionToAnswerMap,
    @required RxMap<Question, QuestionOption> questionToScaleMap,
  });
}

class AttemptQuestionnaireRemoteServiceImpl
    implements AttemptQuestionnaireRemoteService {
  final ApiClient client;
  final ThrowExceptionIfResponseError throwExceptionIfResponseError;

  AttemptQuestionnaireRemoteServiceImpl({
    @required this.client,
    @required this.throwExceptionIfResponseError,
  });
  @override
  Future<SuccessAtemptQuestionnaire> attemptQuestionnaire({
    Questionnaire questionnaire,
    RxMap<Question, dynamic> questionToAnswerMap,
    RxMap<Question, QuestionOption> questionToScaleMap,
  }) async {
    final requestBody = _buildRequestBody(
      questionnaire,
      questionToAnswerMap,
      questionToScaleMap,
    );
    final response = await client.post(
      uri: APIRoute.attemptQuestions,
      body: requestBody,
    );
    throwExceptionIfResponseError(statusCode: response.statusCode);
    return const SuccessAtemptQuestionnaire();
  }

  /// Helper function for generating the requestBody from passed in model & data
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
