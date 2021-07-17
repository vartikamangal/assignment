import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-option-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/questionnaire-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/questionnaire.dart';

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
  final tQuestionModel = [
    QuestionModel(
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
        questionnaireId: 'questionnaireId')
  ];
  final tQuestionnaireModel = QuestionnaireModel(
      id: 'f8c3de3d-1fea-4d7c-a8b0-29f63c4c3454',
      name: 'Test Questionnaire',
      title: 'Just testing',
      description: 'This is test questionnaire',
      creationDate: 'xyz',
      questionVO: <QuestionModel>[
        QuestionModel(
            questionnaireId: "bfeb6f36-2c39-402f-b361-8bd39042e9c4",
            tags: [],
            creationTime: "2021-05-10T14:41:14.769Z",
            questionType: "RATING_SCALE",
            name: "EXpress",
            questionText: "I can easily express my feelings and emotions",
            lastModifiedTime: "2021-05-10T14:41:14.769Z",
            status: "ENABLED",
            questionOptionVO: [],
            questionExplanation: "you can attempt question in this way",
            id: "04ca410e-5188-4d09-8802-b61d5ac3b357")
      ]);
  const tQuestionnaireModel1 = QuestionnaireModel(
      id: 'id',
      name: 'name',
      title: 'title',
      description: 'description',
      creationDate: 'creationDate',
      questionVO: []);

  group('Model QuestionnaireModel', () {
    test('should be a extended version of Questionnaire', () async {
      //assert
      expect(tQuestionnaireModel, isA<Questionnaire>());
    });

    test(' .fromJson should return a valid QuestionnaireModel', () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'questionnaire-model.json'))
              as Map<String, dynamic>;
      //act
      final result = QuestionnaireModel.fromJson(jsonMap);
      //assert
      expect(result, tQuestionnaireModel);
    });

    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final expectedJson =
          jsonDecode(fixtureReader(filename: 'questionnaire-model-from.json'))
              as Map<String, dynamic>;
      //act
      final result = tQuestionnaireModel1.toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}
