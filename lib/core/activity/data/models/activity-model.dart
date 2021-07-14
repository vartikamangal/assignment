// Project imports:
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-step.dart';
import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';

import '../../../image/image.dart';
import '../../../perform-activity/data/models/activity-step-model.dart';
import '../../domain/entities/activity.dart';
import 'recommendation-category-model.dart';
import 'tag-model.dart';

/// Will sort the activitySteps by the order they are displayed in the view
extension on List<ActivityStepModel> {
  List<ActivityStepModel> sortActivitySteps() {
    sort((a, b) => a.stepSequence!.compareTo(b.stepSequence!));
    return this;
  }
}

class ActivityModel extends DataModel<Activity> {
  String? id;
  String? title;
  String? subtitle;
  ImageModel? iconVO;
  int? durationInMinutes;
  String? messageOnReceivingFeedback;
  String? messageOnCompletion;
  String? recommendationStatus;
  String? frequencyMetric;
  int? frequency;
  String? actionTime;
  String? criticality;
  RecommendationCategoryModel? categoryVO;
  List<ActivityStep>? activitySteps;
  List<TagModel>? tags;

  ActivityModel.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] as String?,
        title = jsonMap['title'] as String?,
        subtitle = jsonMap['subtitle'] as String?,
        iconVO = jsonMap["iconVo"] != null
            ? ImageModel.fromJson(jsonMap['iconVO'] as Map<String, dynamic>)
            : ImageModel.fallbackIcon(),
        durationInMinutes = jsonMap['durationInMinutes'] as int?,
        messageOnReceivingFeedback =
            jsonMap['messageOnReceivingFeedback'] as String?,
        messageOnCompletion = jsonMap['messageOnCompletion'] as String?,
        recommendationStatus = jsonMap['recommendationStatus'] as String?,
        frequencyMetric = jsonMap['frequencyMetric'] as String?,
        frequency = jsonMap['frequency'] as int?,
        actionTime = jsonMap['actionTime'] as String?,
        criticality = jsonMap['criticality'] as String?,
        categoryVO = (jsonMap['categoryVO'] != null)
            ? RecommendationCategoryModel.fromJson(
                jsonMap['categoryVO'] as Map<String, dynamic>,
              )
            : (jsonMap['category'] != null)
                ? RecommendationCategoryModel.fromJson(
                    jsonMap['category'] as Map<String, dynamic>,
                  )
                : null,
        activitySteps = (jsonMap['recommendationStepsVO'] != null)
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
                    .sortActivitySteps()
                : null,
        tags = (jsonMap['tags'] as List)
            .map(
              (tag) => TagModel.fromJson(
                tag as Map<String, dynamic>,
              ),
            )
            .toList();

  ActivityModel.fromDomain(Activity activity)
      : id = activity.id,
        title = activity.title,
        subtitle = activity.subtitle,
        iconVO = ImageModel.fromDomain(activity.iconVO!),
        durationInMinutes = activity.durationInMinutes,
        messageOnCompletion = activity.messageOnCompletion,
        recommendationStatus = activity.recommendationStatus,
        frequency = activity.frequency,
        frequencyMetric = activity.frequencyMetric,
        actionTime = activity.actionTime,
        criticality = activity.criticality,
        categoryVO =
            RecommendationCategoryModel.fromDomain(activity.categoryVO!),
        activitySteps = activity.activitySteps,
        tags = activity.tags.map((tag) => TagModel.fromDomain(tag)).toList();

  @override
  Activity toDomain() {
    return Activity(
      actionTime: actionTime,
      frequency: frequency,
      frequencyMetric: frequencyMetric,
      tags: tags!.map((tag) => tag.toDomain()).toList(),
      iconVO: iconVO?.toDomain(),
      id: id,
      messageOnCompletion: messageOnCompletion,
      subtitle: subtitle,
      activitySteps: activitySteps,
      criticality: criticality,
      durationInMinutes: durationInMinutes,
      messageOnReceivingFeedback: messageOnCompletion,
      categoryVO: categoryVO!.toDomain(),
      recommendationStatus: recommendationStatus,
      title: title,
    );
  }

  @override
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
      "tags": tags!
          .map(
            (tag) => tag.toJson(),
          )
          .toList(),
    };
  }
}
