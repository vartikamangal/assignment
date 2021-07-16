import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/get-category-activities-repository.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/get-activity-categories.dart';

import 'get-activity-categories_test.mocks.dart';

@GenerateMocks([GetCategoryActivitiesRepository])
void main() {
  late MockGetCategoryActivitiesRepository repository;
  late GetCategoryActivities useCase;

  setUp(() {
    repository = MockGetCategoryActivitiesRepository();
    useCase = GetCategoryActivities(repository: repository);
  });
  final tCategory = RecommendationCategory(
      id: 1,
      categoryName: "PHYSICAL",
      displayTitle: "Physical",
      displaySubtitle: "Focus on the body",
      categoryDetailedDescription: "This is physical category for body",
      categoryShortDescription: "Focus on the body",
      iconVO: null);
  final tRecommendations = <Recommendation>[
    Recommendation(
        activity: Activity(
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
            ], activitySteps: []),
        weight: 1.0),
    Recommendation(
        activity: Activity(
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
          ], activitySteps: [],
        ),
        weight: 1.0),
    Recommendation(
        activity: Activity(
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
          ], activitySteps: [],
        ),
        weight: 1.0),
  ];
  group('USECASE : getactivity', () {
    test('should return a list of activityCategory using repository', () async {
      //arrange
      when(repository.getActivities(category: tCategory))
          .thenAnswer((_) async =>  Right(tRecommendations));
      //act
      final result =
          await useCase( GetCategoryActivitiesParams(category: tCategory));
      //assert
      verify(repository.getActivities(category: tCategory));
      expect(result,  Right(tRecommendations));
    });
  });
}
