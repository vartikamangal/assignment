import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/feedback.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/feedback-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/feedback-mood-model.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  const List<Feedback> tFeedback = <FeedbackModel>[
    FeedbackModel(
        subjectMoodVO:
            FeedbackMoodModel(mood: "NEUTRAL", activityType: "ONBOARDING"),
        minutesSpent: 15,
        feedbackThoughts: "",
        recommendationId: "",
        actionId: 19389)
  ];

  group('Model FeedbackModel ', () {
    test('should be an extendor of FeedbackModel', () async {
      //assert
      expect(tFeedback.first, isA<Feedback>());
    });
    test('fromJson should transform raw-response into FeedbackModel', () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'feedback.json')) as List;
      //act
      final result = jsonMap
          .map((area) => FeedbackModel.fromMap(area as Map<String, dynamic>))
          .toList();
      //assert
      expect(result, tFeedback);
    });
    test('toJson should transform the model into a Map again', () async {
      //arrange
      final expectedJson =
          jsonDecode(fixtureReader(filename: 'feedback.json')) as List?;
      //act
      final result =
          tFeedback.map((area) => (area as FeedbackModel).toJson()).toList();
      //assert
      expect(result, expectedJson);
    });
  });
}
