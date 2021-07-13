// Project imports:
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-step.dart';

import '../../../image/image.dart';
import '../../../perform-activity/data/models/activity-step-model.dart';
import '../../domain/entities/activity.dart';
import 'recommendation-category-model.dart';
import 'tag-model.dart';

class ActivityModel extends Activity {
  const ActivityModel({
    required String? id,
    required String? title,
    required String? subtitle,
    required String? iconVO,
    required int? durationInMinutes,
    required String? messageOnReceivingFeedback,
    required String? messageOnCompletion,
    required String? recommendationStatus,
    required String? frequencyMetric,
    required int? frequency,
    required String? actionTime,
    required String? criticality,
    required RecommendationCategoryModel? categoryVO,
    required List<ActivityStep>? activitySteps,
    required List<TagModel> tags,
  }) : super(
          frequency: frequency,
          recommendationStatus: recommendationStatus,
          tags: tags,
          messageOnCompletion: messageOnCompletion,
          messageOnReceivingFeedback: messageOnReceivingFeedback,
          iconVO: iconVO,
          id: id,
          categoryVO: categoryVO,
          frequencyMetric: frequencyMetric,
          title: title,
          activitySteps: activitySteps,
          durationInMinutes: durationInMinutes,
          subtitle: subtitle,
          criticality: criticality,
          actionTime: actionTime,
        );

  factory ActivityModel.fromJson(Map<String, dynamic> jsonMap) {
    final activity = ActivityModel(
      id: jsonMap['id'] as String?,
      title: jsonMap['title'] as String?,
      subtitle: jsonMap['subtitle'] as String?,
      iconVO: jsonMap['iconVO'] as String?,
      durationInMinutes: jsonMap['durationInMinutes'] as int?,
      messageOnReceivingFeedback:
          jsonMap['messageOnReceivingFeedback'] as String?,
      messageOnCompletion: jsonMap['messageOnCompletion'] as String?,
      recommendationStatus: jsonMap['recommendationStatus'] as String?,
      frequencyMetric: jsonMap['frequencyMetric'] as String?,
      frequency: jsonMap['frequency'] as int?,
      actionTime: jsonMap['actionTime'] as String?,
      criticality: jsonMap['criticality'] as String?,
      //! Due to change in varNames in GUIDED AND SELF-DRIVEN RESPONSE
      categoryVO: (jsonMap['categoryVO'] != null)
          ? RecommendationCategoryModel.fromJson(
              jsonMap['categoryVO'] as Map<String, dynamic>,
            )
          : (jsonMap['category'] != null)
              ? RecommendationCategoryModel.fromJson(
                  jsonMap['category'] as Map<String, dynamic>,
                )
              : null,
      activitySteps: (jsonMap['recommendationStepsVO'] != null)
          ? (jsonMap['recommendationStepsVO'] as List)
              .map(
                (step) => ActivityStepModel.fromJson(
                  step as Map<String, dynamic>,
                ),
              )
              .toList()
          : (jsonMap['recommendationSteps'] != null)
              ? (jsonMap['recommendationSteps'] as List)
                  .map(
                    (step) => ActivityStepModel.fromJson(
                      step as Map<String, dynamic>,
                    ),
                  )
                  .toList()
              : null,
      tags: (jsonMap['tags'] as List)
          .map(
            (tag) => TagModel.fromJson(
              tag as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
    activity.activitySteps!.sort(
      (a, b) => a.stepSequence!.compareTo(b.stepSequence!),
    );
    return activity;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "subtitle": subtitle,
      "iconVO": iconVO,
      "durationInMinutes": durationInMinutes,
      "messageOnReceivingFeedback": messageOnReceivingFeedback,
      "messageOnCompletion": messageOnCompletion,
      "recommendationStatus": recommendationStatus,
      "frequencyMetric": frequencyMetric,
      "frequency": frequency,
      "actionTime": actionTime,
      "criticality": criticality,
      "categoryVO": (categoryVO as ActivityStepModel).toJson(),
      "recommendationStepsVO": activitySteps!
          .map(
            (step) => (step as ActivityStepModel).toJson(),
          )
          .toList(),
      "tags": tags
          .map(
            (tag) => (tag as TagModel).toJson(),
          )
          .toList(),
    };
  }
}
