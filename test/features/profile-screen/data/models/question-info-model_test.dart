import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/models/question-info-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/question-info.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tQuestionInfoModel = QuestionInfoModel(
    id: 0,
    questionText: 'questionText',
    questionExplanation: 'questionExplanation',
  );
  group('Model QuestionInfoModel', () {
    test('should be a extended version of QuestionInfo', () async {
      //assert
      expect(tQuestionInfoModel, isA<QuestionInfo>());
    });

    test(' .fromJson should return a valid QuestionInfo', () async {
      //arrange
      final jsonMap =
      jsonDecode(fixtureReader(filename: 'question-info-model.json'))
      as Map<String, dynamic>;
      //act
      final result = QuestionInfoModel.fromJson(jsonMap);
      //assert
      expect(result, tQuestionInfoModel);
    });
    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final expectedJson =
      jsonDecode(fixtureReader(filename: 'question-info-model.json'))
      as Map<String, dynamic>;
      //act
      final result = tQuestionInfoModel.toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}