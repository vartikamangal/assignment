// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity/data/models/tag-model.dart';
import '../../domain/entities/question.dart';
import 'question-option-model.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required String? id,
    required String? questionType,
    required String? status,
    required String? name,
    required List<TagModel> tags,
    required List<QuestionOptionModel> questionOptionVO,
    required String? questionText,
    required String? questionExplanation,
    required String? creationTime,
    required String? lastModifiedTime,
    required String? questionnaireId,
  }) : super(
          questionExplanation: questionExplanation,
          questionOptionVO: questionOptionVO,
          creationTime: creationTime,
          id: id,
          questionText: questionText,
          questionType: questionType,
          status: status,
          tags: tags,
          lastModifiedTime: lastModifiedTime,
          questionnaireId: questionnaireId,
          name: name,
        );

  factory QuestionModel.fromJson(Map<String, dynamic> jsonMap) {
    return QuestionModel(
      id: jsonMap['id'] as String?,
      questionType: jsonMap['questionType'] as String?,
      status: jsonMap['status'] as String?,
      name: jsonMap['name'] as String?,
      tags: (jsonMap['tags'] as List)
          .map(
            (tag) => TagModel.fromJson(
              tag as Map<String, dynamic>,
            ),
          )
          .toList(),
      //TODO mess due to inequality in varNames in API response
      questionOptionVO: jsonMap['questionOptionVO'] != null
          ? (jsonMap['questionOptionVO'] as List)
              .map(
                (quesOption) => QuestionOptionModel.fromJson(
                  quesOption as Map<String, dynamic>,
                ),
              )
              .toList()
          : (jsonMap['questionOptions'] as List)
              .map(
                (quesOption) => QuestionOptionModel.fromJson(
                  quesOption as Map<String, dynamic>,
                ),
              )
              .toList(),
      questionText: jsonMap['questionText'] as String?,
      questionExplanation: jsonMap['questionExplanation'] as String?,
      creationTime: jsonMap['creationTime'] as String?,
      lastModifiedTime: jsonMap['lastModifiedTime'] as String?,
      questionnaireId: jsonMap['questionnaireId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "questionType": questionType,
      "status": status,
      "name": name,
      "tags": tags
          .map(
            (tag) => (tag as TagModel).toJson(),
          )
          .toList(),
      "questionOptionVO": questionOptionVO
          .map(
            (quesOptions) => (quesOptions as QuestionOptionModel).toJson(),
          )
          .toList(),
      "questionText": questionText,
      "questionExplanation": questionExplanation,
      "creationTime": creationTime,
      "lastModifiedTime": lastModifiedTime,
      "questionnaireId": questionnaireId,
    };
  }
}
