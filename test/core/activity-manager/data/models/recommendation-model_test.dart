import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/activity-step-model.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-step.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final recommendation = Recommendation(
      activity: Activity(
          id: "08c3275f-e45e-4b6a-bfe7-280266baf6c5",
          title: "GUIDED EXERCISE - 2",
          subtitle: "Subtitle for GUIDED EXERCISE",
          iconVO: ImageEntity(type: 'type', url: 'url'),
          durationInMinutes: 15,
          messageOnReceivingFeedback: " This is an encouraging message",
          messageOnCompletion:
              "Understanding yourself starts with small steps. With regular practices, you will start seeing a positive shift in your mind",
          recommendationStatus: "ENABLED",
          frequencyMetric: "WEEKLY",
          frequency: 1,
          actionTime: "DO_NOW",
          criticality: "LOW",
          categoryVO: null,
          activitySteps: <ActivityStep>[
            ActivityStep(
                id: 3171,
                stepTitle: "Content",
                stepHelp: "stepHelp",
                stepName: "CONTENT",
                stepSequence: 3,
                iconVO: ImageEntity(type: 'type', url: 'url'),
                templateName: "PLAIN_TEXT",
                stepContent:
                    "What is your fondest childhood memory? What made it special?"),
          ],
          tags: <Tag>[
            Tag(
                name: "ROMANCE",
                tagCategory: "AREAS",
                displayName: "Romance",
                parentName: null)
          ]),
      weight: 1.0);
  final List<RecommendationModel> tRecommendationModel = <RecommendationModel>[
    RecommendationModel.fromDomain(
      Recommendation(
          activity: Activity(
              id: "08c3275f-e45e-4b6a-bfe7-280266baf6c5",
              title: "GUIDED EXERCISE - 2",
              subtitle: "Subtitle for GUIDED EXERCISE",
              iconVO: ImageEntity(type: 'type', url: 'url'),
              durationInMinutes: 15,
              messageOnReceivingFeedback: " This is an encouraging message",
              messageOnCompletion:
                  "Understanding yourself starts with small steps. With regular practices, you will start seeing a positive shift in your mind",
              recommendationStatus: "ENABLED",
              frequencyMetric: "WEEKLY",
              frequency: 1,
              actionTime: "DO_NOW",
              criticality: "LOW",
              categoryVO: null,
              activitySteps: <ActivityStep>[
                ActivityStep(
                    id: 3171,
                    stepTitle: "Content",
                    stepHelp: "stepHelp",
                    stepName: "CONTENT",
                    stepSequence: 3,
                    iconVO: ImageEntity(type: 'type', url: 'url'),
                    templateName: "PLAIN_TEXT",
                    stepContent:
                        "What is your fondest childhood memory? What made it special?"),
              ],
              tags: <Tag>[
                Tag(
                    name: "ROMANCE",
                    tagCategory: "AREAS",
                    displayName: "Romance",
                    parentName: null)
              ]),
          weight: 1.0),
    ),
    // RecommendationModel(
    //     activity: ActivityModel(
    //         id: "08c3275f-e45e-4b6a-bfe7-280266baf6c5",
    //         title: "GUIDED EXERCISE - 2",
    //         subtitle: "Subtitle for GUIDED EXERCISE",
    //         iconVO: '',
    //         durationInMinutes: 15,
    //         messageOnReceivingFeedback: " This is an encouraging message",
    //         messageOnCompletion:
    //             "Understanding yourself starts with small steps. With regular practices, you will start seeing a positive shift in your mind",
    //         recommendationStatus: "ENABLED",
    //         frequencyMetric: "WEEKLY",
    //         frequency: 1,
    //         actionTime: "DO_NOW",
    //         criticality: "LOW",
    //         categoryVO:null,
    //         activitySteps: <ActivityStep>[
    //           const ActivityStep(
    //               id: 3171,
    //               stepTitle: "Content",
    //               stepHelp: "",
    //               stepName: "CONTENT",
    //               stepSequence: 3,
    //               iconVO: null,
    //               templateName: "PLAIN_TEXT",
    //               stepContent:
    //                   "What is your fondest childhood memory? What made it special?"),
    //         ],
    //         tags: <TagModel>[
    //           // TagModel(
    //           //     name: "ROMANCE",
    //           //     tagCategory: "AREAS",
    //           //     displayName: "Romance",
    //           //     parentName: null),
    //         ]),
    //     weight: 1.0)
  ];

  final tTags = <TagModel>[
    // TagModel(
    //     name: "LOSING_TEMPER",
    //     tagCategory: "INSTANT_RELIEF",
    //     displayName: "Losing Temper",
    //     parentName: null),
  ];

  test('from domain to take entity and covnert in Recommendation Model',
      () async {
    //act
    final result = RecommendationModel.fromDomain(recommendation);
    //expect
    expect(result, isA<RecommendationModel>());
  });
}
