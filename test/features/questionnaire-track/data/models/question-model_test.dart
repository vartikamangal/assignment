import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-option-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tTagModel = [
    TagModel(
        name: 'name',
        tagCategory: 'tagCategory',
        displayName: 'displayName',
        parentName: 'parentName')
  ];

  const tQuestionOptionModel = [
    QuestionOptionModel(
        id: 'id',
        optionText: 'optionText',
        optionCategory: 'optionCategory',
        additionalInformation: [])
  ];
  const tQuestionModel = QuestionModel(
      id: 'id',
      questionType: 'questionType',
      status: 'status',
      name: 'name',
      tags: tTagModel,
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

    test(' .fromJson should return a valid QuestionModel', () async {
      //arrange
      final jsonMap = jsonDecode(fixtureReader(filename: 'question-model.json'))
          as Map<String, dynamic>;
      //act
      final result = QuestionModel.fromJson(jsonMap);
      //assert
      expect(result, tQuestionModel);
    });

    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final expectedJson =
          jsonDecode(fixtureReader(filename: 'question-model.json'))
              as Map<String, dynamic>;
      //act
      final result = tQuestionModel.toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}
