import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/mood-feedback-model-for-activity.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/mood-feedback-for-activity.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const List<MoodFeedbackForActivity> tMoodFeedbackModelForActivity =
      <MoodFeedbackModelForActivity>[
    MoodFeedbackModelForActivity(mood: 'mood', activityType: 'activityType')
  ];

  group('Model MoodFeedbackModelForActivity ', () {
    test('should be an extendor of MoodFeedbackForActivity', () async {
      //assert
      expect(
          tMoodFeedbackModelForActivity.first, isA<MoodFeedbackForActivity>());
    });
    test(
        'fromJson should transform raw-response into MoodFeedbackActivityModelForActivity',
        () async {
      //arrange
      final jsonMap = jsonDecode(
              fixtureReader(filename: 'raw-mood-feedback-for-activity.json'))
          as List;
      //act
      final result = jsonMap
          .map((area) => MoodFeedbackModelForActivity.fromJson(
              area as Map<String, dynamic>))
          .toList();
      //assert
      expect(result, tMoodFeedbackModelForActivity);
    });
  });
}
