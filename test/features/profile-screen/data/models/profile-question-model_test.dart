import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/models/profile-question-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/data/models/question-info-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/profile-question.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/question-option-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tProfileQuestionModel = ProfileQuestionModel(
      id: 'id',
      questionType: 'questionType',
      status: 'status',
      creationTime: DateTime.parse('2021-05-10T13:19:41.543Z'),
      lastModifiedTime: DateTime.parse('2021-05-10T13:19:41.543Z'),
      name: 'name',
      // ignore: prefer_const_literals_to_create_immutables
      tags: <TagModel>[],
      questionOptions: const [
        QuestionOptionModel(
            id: 'id',
            optionText: 'optionText',
            optionCategory: 'optionCategory',
            additionalInformation: [
              // RatingScaleModel(
              //     min: null,
              //     max: null,
              //     ratingValue: 0,
              //     ratingScaleName: 'ratingScaleName')
            ])
      ],
      questionInformation: const QuestionInfoModel(
          id: null, questionText: '', questionExplanation: ''));
  group('Model QuestionInfoModel', () {
    test('should be a extended version of QuestionInfo', () async {
      //assert
      expect(tProfileQuestionModel, isA<ProfileQuestion>());
    });
  });
}
