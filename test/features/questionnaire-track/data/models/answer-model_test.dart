import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/answer-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-id-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-option-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/answer.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tQuestionIdModel =
  QuestionIdModel(id: '04ca410e-5188-4d09-8802-b61d5ac3b357');

  const tQuestionOptionModel = [
    QuestionOptionModel(
        id: 'id',
        optionText: 'optionText',
        optionCategory: 'optionCategory',
        additionalInformation: [])
  ];

  const tAnswerModel = AnswerModel(
      question: tQuestionIdModel,
      optionChosen: tQuestionOptionModel,
      additionalInformation: '');

  const tAnswerModel1=AnswerModel(
      question: tQuestionIdModel,
      optionChosen: [],
      additionalInformation: '');

  group('Model AnswerModel', () {
    test('should be a extended version of AnswerModel', () async {
      //assert
      expect(tAnswerModel, isA<Answer>());
    });

    test(' .fromJson should return a valid AnswerModel', () async {
      //arrange
      final jsonMap = jsonDecode(fixtureReader(filename: 'answer-model.json'))
      as Map<String, dynamic>;
      //act
      final result = AnswerModel.fromJson(jsonMap);
      //assert
      expect(result, tAnswerModel);
    });

    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final expectedJson =
          jsonDecode(fixtureReader(filename: 'answer-model-from.json'))
              as Map<String, dynamic>;
      //act
      final result = tAnswerModel1.toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}