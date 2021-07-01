import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/feedback-mood.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/feedback-mood-model.dart';
import '../../../../fixtures/fixture-reader.dart';

void main(){
  const List<FeedbackMood> tFeedbackMood=<FeedbackMoodModel>[
    FeedbackMoodModel(
      mood: "NEUTRAL",
      activityType:"ONBOARDING"
    )
  ];


  group('Model FeedbackMoodModel ', () {
    test('should be an extendor of FeedbackMoodModel', () async {
      //assert
      expect(tFeedbackMood.first, isA<FeedbackMood>());
    });
    test('fromJson should transform raw-response into FeedbackMoodModel',
            () async {
          //arrange
          final jsonMap =
          jsonDecode(fixtureReader(filename: 'feedback-mood.json'))
          as List;
          //act
          final result = jsonMap
              .map((area) =>
              FeedbackMoodModel.fromJson(area as Map<String, dynamic>))
              .toList();
          //assert
          expect(result, tFeedbackMood);
        });
    test('toJson should transform the model into a Map again', () async {
      //arrange
      final expectedJson =
      jsonDecode(fixtureReader(filename: 'feedback-mood.json'))
      as List;
      //act
      final result = tFeedbackMood
          .map((area) => (area as FeedbackMoodModel).toJson())
          .toList();
      //assert
      expect(result, expectedJson);
    });
  });
}