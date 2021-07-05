import 'package:flutter/cupertino.dart';

import '../../../../core/activity-management/data/models/tag-model.dart';
import '../../../questionnaire-track/data/models/question-option-model.dart';
import '../../domain/entities/profile-question.dart';
import 'question-info-model.dart';

class ProfileQuestionModel extends ProfileQuestion {
  const ProfileQuestionModel({
    required String? id,
    required String? questionType,
    required String? status,
    required DateTime creationTime,
    required DateTime lastModifiedTime,
    required String? name,
    required List<TagModel> tags,
    required List<QuestionOptionModel> questionOptions,
    required QuestionInfoModel questionInformation,
  }) : super(
          name: name,
          status: status,
          questionInformation: questionInformation,
          lastModifiedTime: lastModifiedTime,
          tags: tags,
          questionOptions: questionOptions,
          id: id,
          creationTime: creationTime,
          questionType: questionType,
        );

  factory ProfileQuestionModel.fromJson(Map<String, dynamic> jsonMap) {
    return ProfileQuestionModel(
      id: jsonMap['id'] as String?,
      questionType: jsonMap['questionType'] as String?,
      status: jsonMap['status'] as String?,
      creationTime: DateTime.parse(jsonMap['creationTime'] as String),
      lastModifiedTime: DateTime.parse(jsonMap['lastModifiedTime'] as String),
      name: jsonMap['name'] as String?,
      tags: (jsonMap['tags'] as List)
          .map(
            (tag) => TagModel.fromJson(tag as Map<String, dynamic>),
          )
          .toList(),
      questionOptions: (jsonMap['questionOptions'] as List)
          .map(
            (option) =>
                QuestionOptionModel.fromJson(option as Map<String, dynamic>),
          )
          .toList(),
      questionInformation: QuestionInfoModel.fromJson(
        jsonMap['questionInformation'] as Map<String, dynamic>,
      ),
    );
  }
}
