import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-id-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-id.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tQuestionIdModel = QuestionIdModel(id: 'id');
  group('Model QuestionIdModel', () {
    test('should be a extended version of QuestionIdModel', () async {
      //assert
      expect(tQuestionIdModel, isA<QuestionId>());
    });

    test(' .fromJson should return a valid QuestionIdModel', () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'question-id-model.json'))
              as Map<String, dynamic>;
      //act
      final result = QuestionIdModel.fromJson(jsonMap);
      //assert
      expect(result, tQuestionIdModel);
    });

    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final expectedJson =
          jsonDecode(fixtureReader(filename: 'question-id-model.json'))
              as Map<String, dynamic>;
      //act
      final result = tQuestionIdModel.toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}
