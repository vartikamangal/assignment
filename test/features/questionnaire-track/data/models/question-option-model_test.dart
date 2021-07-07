
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-option-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-option.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tQuestionOptionModel = QuestionOptionModel(
      id: 'id',
      optionText: 'optionText',
      optionCategory: 'optionCategory',
      additionalInformation: []);
  group('Model QuestionOptionModel', () {
    test('should be a extended version of QuestionOption', () async {
      //assert
      expect(tQuestionOptionModel, isA<QuestionOption>());
    });

    test(' .fromJson should return a valid QuestionOptionModel', () async {
      //arrange
      final jsonMap =
      jsonDecode(fixtureReader(filename: 'question-option-model.json'))
      as Map<String, dynamic>;
      //act
      final result = QuestionOptionModel.fromJson(jsonMap);
      //assert
      expect(result, tQuestionOptionModel);
    });

    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final expectedJson =
      jsonDecode(fixtureReader(filename: 'question-option-model.json'))
      as Map<String, dynamic>;
      //act
      final result = tQuestionOptionModel.toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}