import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/guided-activity-recommendation-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/guided-activity-recommendation.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const List<GuidedActivityRecommendation> tGuidedActivityRecommendation =
  <GuidedActivityRecommendationModel>[
    GuidedActivityRecommendationModel(
        id: 3443,
        dayNumber: 1,
        subtitle: "",
        icon: null,
        description: "Day 1 of stress management",
        title: "Day 1",
        helpContent: "Some useless help content",
        recommendationList: <ActivityModel>[
          ActivityModel(
              id: 'test_id',
              title: 'test',
              subtitle: 'subtitle',
              iconVO: '',
              durationInMinutes: 3,
              messageOnReceivingFeedback: 'ddd',
              messageOnCompletion: 'ddd',
              recommendationStatus: 'dddd',
              frequencyMetric: 'test_f',
              frequency: 1,
              actionTime: 'fdd',
              criticality: 'test',
              categoryVO: RecommendationCategoryModel(
                  id: 1,
                  categoryName: '',
                  displayTitle: '',
                  displaySubtitle: '',
                  categoryDetailedDescription: '',
                  categoryShortDescription: '',
                  iconVO: null),
              activitySteps: [],
              tags: [])
        ])
  ];

  group('Model GuidedActivityRecommendation ', () {
    test('should be an extendor of GuidedActivityRecommendation', () async {
      //assert
      expect(tGuidedActivityRecommendation.first,
          isA<GuidedActivityRecommendation>());
    });
    // test(
    //     'fromJson should transform raw-response into GuidedActivityRecommendation',
    //         () async {
    //       //arrange
    //       final jsonMap = jsonDecode(
    //           fixtureReader(filename: 'guided-activity-recommendation.json'))
    //       as List;
    //       //act
    //       final result = jsonMap
    //           .map((area) => GuidedActivityRecommendationModel.fromJson(
    //           area as Map<String, dynamic>))
    //           .toList();
    //       //assert
    //       expect(result, tGuidedActivityRecommendation);
    //     });
    // test('toJson should transform the model into a Map again', () async {
    //   //arrange
    //   final expectedJson =
    //   jsonDecode(fixtureReader(filename: 'guided-activity-recommendation.json'))
    //   as List;
    //   //act
    //   final result = tGuidedActivityRecommendation
    //       .map((area) => (area as GuidedActivityRecommendationModel).toJson())
    //       .toList();
    //   //assert
    //   expect(result, expectedJson);
    // });
  });
}