import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/models/profile-question-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/models/question-info-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/models/question-log-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/question-log.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-option-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tQuestionLogModel = QuestionLogModel(
      id: 1,
      answeredWhen: DateTime.parse('2021-05-10T13:19:41.543Z'),
      question: ProfileQuestionModel(
          id: 'id',
          questionType: 'questionType',
          status: 'status',
          creationTime: DateTime.parse('2021-05-10T13:19:41.543Z'),
          lastModifiedTime: DateTime.parse('2021-05-10T13:19:41.543Z'),
          name: 'name',
          tags: const [],
          questionOptions: const [
            QuestionOptionModel(
                id: 'id',
                optionText: 'optionText',
                optionCategory: 'optionCategory',
                additionalInformation: [
                  // RatingScaleModel(
                  //     min: 0,
                  //     max: 0,
                  //     ratingValue: 0,
                  //     ratingScaleName: 'ratingScaleName')
                ])
          ],
          questionInformation: const QuestionInfoModel(
              id: null, questionText: '', questionExplanation: '')),
      optionChosen: const [
        QuestionOptionModel(
            id: '',
            optionText: '',
            optionCategory: '',
            additionalInformation: [])
      ],
      additionalInformation: null);
  group('Model QuestionLogModel', () {
    test('should be a extended version of QuestionLogModel', () async {
      expect(tQuestionLogModel, isA<QuestionLog>());
    });
    test(' .fromJson should return a valid QuestionInfo', () async {
      //arrange
      final jsonMap =
      jsonDecode(fixtureReader(filename: 'question-log-model.json'))
      as Map<String, dynamic>;
      //act
      final result = QuestionLogModel.fromJson(jsonMap);
      //assert
      expect(result, tQuestionLogModel);
    });
  });
}
