import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/activity-schedule-guided.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/guided-activity-recommendation.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/path-information-guided.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-activity.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-step.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/repositories/get-activity-schedule-for-guided-plan-repository.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/usecases/get-activity-schedule-for-guided-plan.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class MockGetActivityScheduleForGuidedPlanRepository extends Mock
    implements GetActivitySceduleForGuidedPlanRepository {}

void main() {
  MockGetActivityScheduleForGuidedPlanRepository repository;
  GetActivityScheduleForGuidedPlan useCase;

  setUp(() {
    repository = MockGetActivityScheduleForGuidedPlanRepository();
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
          recommendationList: <ActivityRecommendation>[
            ActivityRecommendation(
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
                        "The idea here is to record detailed descriptions of certain aspects of events, thoughts and feelings. Be as descriptive as possible and write down everything! The act of writing gives you perspectives that you may not consider if you just think about something."),
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
            ),
            ActivityRecommendation(
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
              ),
              recommendationStepsVO: <RecommendationStep>[
                RecommendationStep(
                    id: 3142,
                    stepTitle: "Content",
                    stepHelp:
                        "Focus on the small, positive things âor become more aware of the small, good things that were already happening in your life.",
                    stepName: "CONTENT",
                    stepSequence: 3,
                    iconVO: null,
                    templateName: "PLAIN_TEXT",
                    stepContent:
                        "What were 3 surprises that came your way this week?"),
                RecommendationStep(
                    id: 3141,
                    stepTitle: "Instructions",
                    stepHelp: "",
                    stepName: "INSTRUCTIONS",
                    stepSequence: 2,
                    iconVO: null,
                    templateName: "PLAIN_TEXT",
                    stepContent:
                        "To stimulate the experience of gratitude take a minute to ponder what life would be like without all that you have. Focus on people, surprises, your environment or events rather than material possessions."),
                RecommendationStep(
                    id: 3140,
                    stepTitle: "Did you know?",
                    stepHelp: "",
                    stepName: "DID_YOU_KNOW",
                    stepSequence: 1,
                    iconVO: null,
                    templateName: "PLAIN_TEXT",
                    stepContent:
                        "Grateful people experience fewer aches and pains and they report feeling healthier than other people"),
              ],
            ),
            ActivityRecommendation(
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
              ),
              recommendationStepsVO: <RecommendationStep>[
                RecommendationStep(
                    id: 3323,
                    stepTitle: "Content",
                    stepHelp: "",
                    stepName: "CONTENT",
                    stepSequence: 3,
                    iconVO: null,
                    templateName: "PLAIN_TEXT",
                    stepContent:
                        "What is your fondest childhood memory? What made it special?"),
                RecommendationStep(
                    id: 3322,
                    stepTitle: "Instructions",
                    stepHelp: "",
                    stepName: "INSTRUCTIONS",
                    stepSequence: 2,
                    iconVO: null,
                    templateName: "PLAIN_TEXT",
                    stepContent:
                        "The idea here is to record detailed descriptions of certain aspects of events, thoughts and feelings. Be as descriptive as possible and write down everything! The act of writing gives you perspectives that you may not consider if you just think about something."),
                RecommendationStep(
                    id: 3321,
                    stepTitle: "Did you know?",
                    stepHelp: "",
                    stepName: "DID_YOU_KNOW",
                    stepSequence: 1,
                    iconVO: null,
                    templateName: "PLAIN_TEXT",
                    stepContent: "Some useful did you know fact"),
              ],
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
