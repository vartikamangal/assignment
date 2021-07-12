import 'dart:convert';

import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-option-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/questionnaire-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-option.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/questionnaire.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/success-atempt-questionnaire.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';

abstract class QuestionnaireRemoteDataSource {
  Future<SuccessAtemptQuestionnaire> attemptQuestionnaire({
    required Questionnaire? questionnaire,
    required RxMap<Question, dynamic>? questionToAnswerMap,
    required RxMap<Question, QuestionOption>? questionToScaleMap,
  });
  Future<QuestionnaireModel> getQuestionnaireById({
    required String? id,
  });
}

class QuestionnaireRemoteDataSourceImpl
    implements QuestionnaireRemoteDataSource {
  final ApiClient? client;
  final ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  QuestionnaireRemoteDataSourceImpl({
    required this.client,
    required this.throwExceptionIfResponseError,
  });
  @override
  Future<SuccessAtemptQuestionnaire> attemptQuestionnaire({
    Questionnaire? questionnaire,
    RxMap<Question, dynamic>? questionToAnswerMap,
    RxMap<Question, QuestionOption>? questionToScaleMap,
  }) async {
    final requestBody = _buildRequestBody(
      questionnaire!,
      questionToAnswerMap,
      questionToScaleMap,
    );
    final response = await client!.post(
      uri: APIRoute.attemptQuestions,
      body: requestBody,
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    return const SuccessAtemptQuestionnaire();
  }

  @override
  Future<QuestionnaireModel> getQuestionnaireById({String? id}) async {
    final response = await client!.get(
      uri: "${APIRoute.getQuestionnaire}/$id",
    );
    throwExceptionIfResponseError!(statusCode: response.statusCode);
    return QuestionnaireModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  /// Helper function for generating the requestBody from passed in model & data
  /// This should be moved to models
  String _buildRequestBody(
    Questionnaire questionnaire,
    RxMap<Question, dynamic>? questionToAnswerMap,
    RxMap<Question, QuestionOption>? questionToScaleMap,
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
              (questionToAnswerMap![question] as QuestionOptionModel).toJson(),
            ],
          },
        );
      } else {
        // Request body type for RatingScale Type questions
        final double rating =
            (questionToAnswerMap![question] as num).toDouble();
        body.add(
          {
            "question": {
              "id": question.id,
            },
            "additionalInformation": "rating: $rating",
            "optionChosen": [
              {
                "RatingScale":
                    ((questionToScaleMap![question] as QuestionOptionModel)
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
