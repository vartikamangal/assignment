import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/guided-activity-recommendation.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

void main() {
  final tActivity = Activity(
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
      activitySteps: []);
  final tGuidedActivityRecommendationModel = GuidedActivityRecommendation(
      id: 1,
      dayNumber: 1,
      icon: ImageEntity(type: 'type', url: 'url'),
      description: 'description',
      title: 'title',
      subtitle: 'subtitle',
      helpContent: 'helpContent',
      recommendationList: [tActivity]);
}
