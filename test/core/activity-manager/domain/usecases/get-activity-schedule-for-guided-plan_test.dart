import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity-schedule-guided.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/guided-activity-recommendation.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/path-information-guided.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/get-activity-schedule-for-guided-plan-repository.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/get-activity-schedule-for-guided-plan.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-step.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

import 'get-activity-schedule-for-guided-plan_test.mocks.dart';

@GenerateMocks([GetActivitySceduleForGuidedPlanRepository])
void main() {
  late MockGetActivitySceduleForGuidedPlanRepository repository;
  late GetActivityScheduleForGuidedPlan useCase;

  setUp(() {
    repository = MockGetActivitySceduleForGuidedPlanRepository();
    useCase = GetActivityScheduleForGuidedPlan(repository: repository);
  });

  const tActivitySceduleGuided = ActivitySceduleGuided(
    id: 3441,
    tags: [],
    pathInformation: PathInformation(
        id: 3442,
        description: "Curated Path for stress management",
        title: "Stress management",
        subtitle: "This will help you manage stress better",
        helpContent: "Just putting some help content for future use",
        lengthOfPlan: 23),
    activitySchedule: <GuidedActivityRecommendation>[
      GuidedActivityRecommendation(
          id: 3443,
          dayNumber: 1,
          icon: null,
          description: "Day 1 of stress management",
          title: "Day 1",
          subtitle: "Perform this day with smile",
          helpContent: "Some useless help content",
          recommendationList: <Activity>[
            Activity(
              id: "08c3275f-e45e-4b6a-bfe7-280266baf6c5",
              title: "GUIDED EXERCISE - 2",
              subtitle: "Subtitle for GUIDED EXERCISE",
              iconVO: null,
              durationInMinutes: 15,
              messageOnReceivingFeedback: "This is an encouraging message",
              messageOnCompletion:
                  "Understanding yourself starts with small steps. With regular practices, you will start seeing a positive shift in your mind",
              recommendationStatus: "ENABLED",
              frequencyMetric: "WEEKLY",
              frequency: 1,
              actionTime: "DO_NOW",
              criticality: "LOW",

              //tags are not same type
              tags: <Tag>[],
              categoryVO: RecommendationCategory(
                  id: 1,
                  categoryName: "PHYSICAL",
                  displayTitle: "Physical",
                  displaySubtitle: "Focus on the body",
                  categoryDetailedDescription:
                      "This is physical category for body",
                  categoryShortDescription: "Focus on the body",
                  iconVO: null),
           activitySteps: [],
            ),
            Activity(
              id: "554e6ad7-42ca-4c56-bc0a-4cf96a902812",
              title: "Gratitude Journal",
              subtitle: "Reflective Writing",
              iconVO: null,
              durationInMinutes: 15,
              messageOnReceivingFeedback:
                  "This is an encouraging message for gratitude journal",
              messageOnCompletion:
                  "Understanding yourself starts with small steps. With regular practices, you will start seeing a positive shift in your mind",
              recommendationStatus: "ENABLED",
              frequencyMetric: "WEEKLY",
              frequency: 1,
              actionTime: "DO_NOW",
              criticality: "LOW",
              //tags are not same type
              tags: <Tag>[],
              categoryVO: RecommendationCategory(
                id: 4,
                categoryName: "SPIRITUAL",
                displayTitle: "Spiritual",
                displaySubtitle: "Focus on the world around",
                categoryDetailedDescription: "This is Spiritual category",
                categoryShortDescription: "Focus on the world around",
                iconVO: null,
              ), activitySteps: [],
            ),
            Activity(
              id: "29f29728-424e-4ae8-8338-e0fbaaedc101",
              title: "Reflective Journaling - 2",
              subtitle: "Reflective Writing",
              iconVO: null,
              durationInMinutes: 15,
              messageOnReceivingFeedback: "This is an encouraging message,",
              messageOnCompletion:
                  "Understanding yourself starts with small steps. With regular practices, you will start seeing a positive shift in your mind",
              recommendationStatus: "ENABLED",
              frequencyMetric: "WEEKLY",
              frequency: 1,
              actionTime: "DO_LATER",
              criticality: "LOW",
              //tags are not same type
              tags: <Tag>[],
              categoryVO: RecommendationCategory(
                id: 3,
                categoryName: "EMOTIONAL",
                displayTitle: "Emotional",
                displaySubtitle: "Focus on your relationships",
                categoryDetailedDescription: "This is emotional category",
                categoryShortDescription: "Focus on your relationships",
                iconVO: null,
              ), activitySteps: [],
            )
          ])
    ],
  );

  group('USECASE : getSchedule', () {
    test('should return a Activity scheduled plan using repository', () async {
      //arrange
      when(repository.getSchedule())
          .thenAnswer((_) async => const Right(tActivitySceduleGuided));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getSchedule());
      expect(result, const Right(tActivitySceduleGuided));
    });
  });
}
