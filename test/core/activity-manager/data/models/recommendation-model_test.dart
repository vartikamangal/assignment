import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-activity-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-step-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

void main() {
  const List<Recommendation> tRecommendationModel = <RecommendationModel>[
    RecommendationModel(
        activity: ActivityRecommendationModel(
            id: "08c3275f-e45e-4b6a-bfe7-280266baf6c5",
            title: "GUIDED EXERCISE - 2",
            subtitle: "Subtitle for GUIDED EXERCISE",
            iconVO: ImageProp(urlShort: '', urlLarge: '', urlMedium: ''),
            durationInMinutes: 15,
            messageOnReceivingFeedback: " This is an encouraging message",
            messageOnCompletion:
                "Understanding yourself starts with small steps. With regular practices, you will start seeing a positive shift in your mind",
            recommendationStatus: "ENABLED",
            frequencyMetric: "WEEKLY",
            frequency: 1,
            actionTime: "DO_NOW",
            criticality: "LOW",
            categoryVO: RecommendationCategoryModel(
                id: 1,
                categoryName: "PHYSICAL",
                displayTitle: "Physical",
                displaySubtitle: "Focus on the body",
                categoryDetailedDescription:
                    "This is physical category for body",
                categoryShortDescription: "Focus on the body",
                iconVO: ImageProp(urlShort: '', urlLarge: '', urlMedium: '')),
            recommendationStepsVO: <RecommendationStepModel>[
              /*   RecommendationStepModel(
              id: 3171,
              stepTitle: "Content",
              stepHelp: "" ,
              stepName: "CONTENT",
              stepSequence: 3,
              iconVO: ImageProp(urlShort: '',
                  urlLarge: '',
                  urlMedium: ''),
              templateName: "PLAIN_TEXT",
              stepContent: "What is your fondest childhood memory? What made it special?"
          ),
          RecommendationStepModel(
            id: 3170,
            stepTitle: "Instructions",
            stepHelp: "",
            stepName: "INSTRUCTIONS",
            stepSequence: 2,
            iconVO: ImageProp(urlShort: '',
                urlLarge: '',
                urlMedium: ''),
            templateName: "PLAIN_TEXT",
            stepContent: "The idea here is to record detailed descriptions of certain aspects of events, thoughts and feelings. Be as descriptive as possible and write down everything! The act of writing gives you perspectives that you may not consider if you just think about something.",

          ),
          RecommendationStepModel(
              id: 3169,
              stepTitle: "Did you know?",
              stepHelp: "",
              stepName: "DID_YOU_KNOW",
              stepSequence: 1,
              iconVO: ImageProp(urlShort: '',
                  urlLarge: '',
                  urlMedium: ''),
              templateName: "PLAIN_TEXT",
              stepContent: "Some useful did you know fact"
          ),*/
            ],
            tags: <TagModel>[
              /*TagModel(name: "ROMANCE",
              tagCategory: "AREAS",
              displayName: "Romance",
              parentName: null),
          TagModel(name: "ROMANCE_LOW",
              tagCategory: "WOL_SATISFACTION_RATING",
              displayName: "Satisfaction low for Romance",
              parentName: "ROMANCE"),
          TagModel(name: "WORK_FROM_HOME",
              tagCategory: "FOCUS_ISSUE",
              displayName:"Work form home",
              parentName: null),
          TagModel(name: "LOSING_TEMPER",
              tagCategory: "INSTANT_RELIEF",
              displayName: "Losing Temper",
              parentName: null),*/
            ]),
        weight: 1.0)
  ];

  group('Model RecommendationModel ', () {
    test('should be an extendor of RecommendationModel', () async {
      //assert
      expect(tRecommendationModel.first, isA<RecommendationModel>());
    });
    // test('fromJson should transform raw-response into RecommendationModel',
    //         () async {
    //       //arrange
    //       final jsonMap =
    //       jsonDecode(fixtureReader(filename: 'recommendation-model.json'))
    //       as List;
    //       //act
    //       final result = jsonMap
    //           .map((area) =>
    //           RecommendationModel.fromJson(area as Map<String, dynamic>))
    //           .toList();
    //       //assert
    //       expect(result, tRecommendationModel);
    //     });
    // test('toJson should transform the model into a Map again', () async {
    //   //arrange
    //   final expectedJson =
    //   jsonDecode(fixtureReader(filename: 'raw-tag-model.json'))
    //   as List;
    //   //act
    //   final result = tTags
    //       .map((area) => (area as TagModel).toJson())
    //       .toList();
    //   //assert
    //   expect(result, expectedJson);
    // });
  });
}
