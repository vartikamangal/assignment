import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tRecommendation = Recommendation(
      activity: Activity(
          id: "08c3275f-e45e-4b6a-bfe7-280266baf6c5",
          title: "GUIDED EXERCISE - 2",
          subtitle: "Subtitle for GUIDED EXERCISE",
          iconVO: ImageEntity(
              type: '',
              url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
          durationInMinutes: 15,
          messageOnReceivingFeedback: " This is an encouraging message",
          messageOnCompletion:
              "Understanding yourself starts with small steps. With regular practices, you will start seeing a positive shift in your mind",
          recommendationStatus: "ENABLED",
          frequencyMetric: "WEEKLY",
          frequency: 1,
          actionTime: "DO_NOW",
          criticality: "LOW",
          categoryVO: RecommendationCategory(
              id: 1,
              categoryName: "PHYSICAL",
              displayTitle: "Physical",
              displaySubtitle: "Focus on the body",
              categoryDetailedDescription: "This is physical category for body",
              categoryShortDescription: "Focus on the body",
              iconVO: ImageEntity(
                  type: '',
                  url:
                      'https://images.unsplash.com/photo-1547721064-da6cfb341d50')),
          tags: <Tag>[
            Tag(
                name: "ROMANCE",
                tagCategory: "AREAS",
                displayName: "Romance",
                parentName: null),
            Tag(
                name: "ROMANCE_LOW",
                tagCategory: "WOL_SATISFACTION_RATING",
                displayName: "Satisfaction low for Romance",
                parentName: "ROMANCE"),
            Tag(
                name: "WORK_FROM_HOME",
                tagCategory: "FOCUS_ISSUE",
                displayName: "Work form home",
                parentName: null),
            Tag(
                name: "LOSING_TEMPER",
                tagCategory: "INSTANT_RELIEF",
                displayName: "Losing Temper",
                parentName: null),
          ],
          activitySteps: []),
      weight: 1.0);

  final tRecommendationModel = RecommendationModel.fromDomain(Recommendation(
      activity: Activity(
          id: "08c3275f-e45e-4b6a-bfe7-280266baf6c5",
          title: "GUIDED EXERCISE - 2",
          subtitle: "Subtitle for GUIDED EXERCISE",
          iconVO: ImageEntity(
              type: '',
              url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
          durationInMinutes: 15,
          messageOnReceivingFeedback: " This is an encouraging message",
          messageOnCompletion:
              "Understanding yourself starts with small steps. With regular practices, you will start seeing a positive shift in your mind",
          recommendationStatus: "ENABLED",
          frequencyMetric: "WEEKLY",
          frequency: 1,
          actionTime: "DO_NOW",
          criticality: "LOW",
          categoryVO: RecommendationCategory(
              id: 1,
              categoryName: "PHYSICAL",
              displayTitle: "Physical",
              displaySubtitle: "Focus on the body",
              categoryDetailedDescription: "This is physical category for body",
              categoryShortDescription: "Focus on the body",
              iconVO: ImageEntity(
                  type: '',
                  url:
                      'https://images.unsplash.com/photo-1547721064-da6cfb341d50')),
          tags: <Tag>[
            Tag(
                name: "ROMANCE",
                tagCategory: "AREAS",
                displayName: "Romance",
                parentName: null),
            Tag(
                name: "ROMANCE_LOW",
                tagCategory: "WOL_SATISFACTION_RATING",
                displayName: "Satisfaction low for Romance",
                parentName: "ROMANCE"),
            Tag(
                name: "WORK_FROM_HOME",
                tagCategory: "FOCUS_ISSUE",
                displayName: "Work form home",
                parentName: null),
            Tag(
                name: "LOSING_TEMPER",
                tagCategory: "INSTANT_RELIEF",
                displayName: "Losing Temper",
                parentName: null),
          ],
          activitySteps: []),
      weight: 1.0));

  test('from domain to take entity and covert in ActivityStatusModel',
      () async {
    //act
    final result = RecommendationModel.fromDomain(tRecommendation);
    //expect
    expect(result, isA<RecommendationModel>());
  });

  test('from json should return valid ActivityStatusModel', () async {
    //arrange
    final jsonMap =
        jsonDecode(fixtureReader(filename: 'raw-recommendation-model.json'))
            as List<dynamic>;
    //act
    final result =
        RecommendationModel.fromJson(jsonMap.first as Map<String, dynamic>);

    //expect
    expect(result.toString(), tRecommendationModel.toString());
  });

  test(
      'To json of ActivityStatusModel should return a json ActivityStatusModel',
      () async {
    //arrange
    final jsonMap =
        jsonDecode(fixtureReader(filename: 'raw-recommendation-model.json'))
            as List;
    //act
    final j = tRecommendationModel.toJson();
    //expect
    expect(jsonMap.first, j);
  });
  test('To domain should return ActivityStatus', () async {
    //act
    final result = tRecommendationModel.toDomain();
    //expect
    expect(result, isA<Recommendation>());
  });
}
