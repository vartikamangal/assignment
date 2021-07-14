import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/activity_rating_model.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/mood-feedback-model-for-activity.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity_rating.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tMoodFeedbackModelForActivity =
      MoodFeedbackModelForActivity(mood: 'mood', activityType: 'activityType');

  const List<ActivityRating> tActivityRatingModel = <ActivityRatingModel>[
    ActivityRatingModel(
        subjectMoodVO: tMoodFeedbackModelForActivity,
        minutesSpent: 1,
        feedbackThoughts: 'feedbackThoughts',
        recommendationId: 'recommendationId',
        actionId: 1)
  ];

  group('Model ActivityRatingModel ', () {
    test('should be an extendor of ActivityRating', () async {
      //assert
      expect(tActivityRatingModel.first, isA<ActivityRating>());
    });
    test('fromJson should transform raw-response into ActivityRatingModel',
        () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'raw-activity-rating-model.json'))
              as List;
      //act
      final result = jsonMap
          .map((area) =>
              ActivityRatingModel.fromMap(area as Map<String, dynamic>))
          .toList();
      //assert
      expect(result, tActivityRatingModel);
    });
  });
}
