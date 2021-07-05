import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-activity.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-step.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/repositories/get-category-activities-repository.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/usecases/get-activity-categories.dart';

import 'get-activity-categories_test.mocks.dart';

@GenerateMocks([GetCategoryActivitiesRepository])
void main() {
  late MockGetCategoryActivitiesRepository repository;
  late GetCategoryActivities useCase;

  setUp(() {
    repository = MockGetCategoryActivitiesRepository();
    useCase = GetCategoryActivities(repository: repository);
  });
  const tCategory = RecommendationCategoryModel(
      id: 1,
      categoryName: "PHYSICAL",
      displayTitle: "Physical",
      displaySubtitle: "Focus on the body",
      categoryDetailedDescription: "This is physical category for body",
      categoryShortDescription: "Focus on the body",
      iconVO: null);
  const tRecommendations = <Recommendation>[
    Recommendation(
        activity: ActivityRecommendation(
            id: "08c3275f-e45e-4b6a-bfe7-280266baf6c5",
            title: "GUIDED EXERCISE - 2",
            subtitle: "Subtitle for GUIDED EXERCISE",
            iconVO: null,
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
                categoryDetailedDescription:
                    "This is physical category for body",
                categoryShortDescription: "Focus on the body",
                iconVO: null),
            recommendationStepsVO: <RecommendationStep>[
              RecommendationStep(
                  id: 3171,
                  stepTitle: "Content",
                  stepHelp: "",
                  stepName: "CONTENT",
                  stepSequence: 3,
                  iconVO: null,
                  templateName: "PLAIN_TEXT",
                  stepContent:
                      "What is your fondest childhood memory? What made it special?"),
              RecommendationStep(
                id: 3170,
                stepTitle: "Instructions",
                stepHelp: "",
                stepName: "INSTRUCTIONS",
                stepSequence: 2,
                iconVO: null,
                templateName: "PLAIN_TEXT",
                stepContent:
                    "The idea here is to record detailed descriptions of certain aspects of events, thoughts and feelings. Be as descriptive as possible and write down everything! The act of writing gives you perspectives that you may not consider if you just think about something.",
              ),
              RecommendationStep(
                  id: 3169,
                  stepTitle: "Did you know?",
                  stepHelp: "",
                  stepName: "DID_YOU_KNOW",
                  stepSequence: 1,
                  iconVO: null,
                  templateName: "PLAIN_TEXT",
                  stepContent: "Some useful did you know fact"),
            ],
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
            ]),
        weight: 1.0),
    Recommendation(
        activity: ActivityRecommendation(
          id: "dca6f8fa-18ca-499a-8981-92c181917184",
          title: "GUIDED EXERCISE - 2",
          subtitle: "Subtitle for GUIDED EXERCISE",
          iconVO: null,
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
              iconVO: null),
          recommendationStepsVO: <RecommendationStep>[
            RecommendationStep(
                id: 96,
                stepTitle: "Content",
                stepHelp: "",
                stepName: "CONTENT",
                stepSequence: 3,
                iconVO: null,
                templateName: "PLAIN_TEXT",
                stepContent:
                    "What is your fondest childhood memory? What made it special?"),
            RecommendationStep(
                id: 95,
                stepTitle: "Instructions",
                stepHelp: "",
                stepName: "INSTRUCTIONS",
                stepSequence: 2,
                iconVO: null,
                templateName: "PLAIN_TEXT",
                stepContent:
                    "The idea here is to record detailed descriptions of certain aspects of events, thoughts and feelings. Be as descriptive as possible and write down everything! The act of writing gives you perspectives that you may not consider if you just think about something."),
            RecommendationStep(
                id: 94,
                stepTitle: "Did you know?",
                stepHelp: "",
                stepName: "DID_YOU_KNOW",
                stepSequence: 1,
                iconVO: null,
                templateName: "PLAIN_TEXT",
                stepContent: "Some useful did you know fact"),
          ],
          tags: <Tag>[
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
            Tag(
                name: "ROMANCE_LOW",
                tagCategory: "WOL_SATISFACTION_RATING",
                displayName: "Satisfaction low for Romance",
                parentName: "ROMANCE"),
            Tag(
                name: "ROMANCE",
                tagCategory: "AREAS",
                displayName: "Romance",
                parentName: null),
          ],
        ),
        weight: 1.0),
    Recommendation(
        activity: ActivityRecommendation(
          id: "ca4176b7-55ea-454f-a653-dbc08280b11e",
          title: "GUIDED EXERCISE - 2",
          subtitle: "Subtitle for GUIDED EXERCISE",
          iconVO: null,
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
              iconVO: null),
          recommendationStepsVO: <RecommendationStep>[
            RecommendationStep(
                id: 3329,
                stepTitle: "Content",
                stepHelp: "",
                stepName: "CONTENT",
                stepSequence: 3,
                iconVO: null,
                templateName: "PLAIN_TEXT",
                stepContent:
                    "What is your fondest childhood memory? What made it special?"),
            RecommendationStep(
                id: 3328,
                stepTitle: "Instructions",
                stepHelp: "",
                stepName: "INSTRUCTIONS",
                stepSequence: 2,
                iconVO: null,
                templateName: "PLAIN_TEXT",
                stepContent:
                    " The idea here is to record detailed descriptions of certain aspects of events, thoughts and feelings. Be as descriptive as possible and write down everything! The act of writing gives you perspectives that you may not consider if you just think about something."),
            RecommendationStep(
                id: 3327,
                stepTitle: "Did you know?",
                stepHelp: "",
                stepName: "DID_YOU_KNOW",
                stepSequence: 1,
                iconVO: null,
                templateName: "PLAIN_TEXT",
                stepContent: "Some useful did you know fact"),
          ],
          tags: <Tag>[
            Tag(
                name: "LOSING_TEMPER",
                tagCategory: "INSTANT_RELIEF",
                displayName: "Losing Temper",
                parentName: null),
            Tag(
                name: "ROMANCE_LOW",
                tagCategory: "WOL_SATISFACTION_RATING",
                displayName: "Satisfaction low for Romance",
                parentName: "ROMANCE"),
            Tag(
                name: "ROMANCE",
                tagCategory: "AREAS",
                displayName: "Romance",
                parentName: null),
            Tag(
                name: "WORK_FROM_HOME",
                tagCategory: "FOCUS_ISSUE",
                displayName: "Work form home",
                parentName: null),
          ],
        ),
        weight: 1.0),
  ];
  group('USECASE : getactivity', () {
    test('should return a list of activityCategory using repository', () async {
      //arrange
      when(repository.getActivities(category: tCategory))
          .thenAnswer((_) async => const Right(tRecommendations));
      //act
      final result =
          await useCase(const GetCategoryActivitiesParams(category: tCategory));
      //assert
      verify(repository.getActivities(category: tCategory));
      expect(result, const Right(tRecommendations));
    });
  });
}
