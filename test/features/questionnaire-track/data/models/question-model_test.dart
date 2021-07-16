import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-option-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  // const tTagModel = [
  //   TagModel(
  //       name: 'name',
  //       tagCategory: 'tagCategory',
  //       displayName: 'displayName',
  //       parentName: 'parentName')
  // ];

  const tQuestionOptionModel = [
    QuestionOptionModel(
        id: 'id',
        optionText: 'optionText',
        optionCategory: 'optionCategory',
        additionalInformation: [])
  ];
  final tQuestionModel = QuestionModel(
      id: 'id',
      questionType: 'questionType',
      status: 'status',
      name: 'name',
      tags: [],
      questionOptionVO: tQuestionOptionModel,
      questionText: 'questionText',
      questionExplanation: 'questionExplanation',
      creationTime: 'creationTime',
      lastModifiedTime: 'lastModifiedTime',
      questionnaireId: 'questionnaireId');
  group('Model QuestionIdModel', () {
    test('should be a extended version of Question', () async {
      //assert
      expect(tQuestionModel, isA<Question>());
    });
  });
}
