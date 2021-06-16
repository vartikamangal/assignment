// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entities/recommendation-activity.dart';
import 'recommendation-category-model.dart';
import 'recommendation-step-model.dart';
import 'tag-model.dart';

class ActivityRecommendationModel extends ActivityRecommendation {
  const ActivityRecommendationModel({
    @required String id,
    @required String title,
    @required String subtitle,
    @required ImageProp iconVO,
    @required int durationInMinutes,
    @required String messageOnReceivingFeedback,
    @required String messageOnCompletion,
    @required String recommendationStatus,
    @required String frequencyMetric,
    @required int frequency,
    @required String actionTime,
    @required String criticality,
    @required RecommendationCategoryModel categoryVO,
    @required List<RecommendationStepModel> recommendationStepsVO,
    @required List<TagModel> tags,
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
          recommendationStepsVO: recommendationStepsVO,
          durationInMinutes: durationInMinutes,
          subtitle: subtitle,
          criticality: criticality,
          actionTime: actionTime,
        );

  factory ActivityRecommendationModel.fromJson(Map<String, dynamic> jsonMap) {
    return ActivityRecommendationModel(
      id: jsonMap['id'] as String,
      title: jsonMap['title'] as String,
      subtitle: jsonMap['subtitle'] as String,
      iconVO: const ImageProp(),
      durationInMinutes: jsonMap['durationInMinutes'] as int,
      messageOnReceivingFeedback:
          jsonMap['messageOnReceivingFeedback'] as String,
      messageOnCompletion: jsonMap['messageOnCompletion'] as String,
      recommendationStatus: jsonMap['recommendationStatus'] as String,
      frequencyMetric: jsonMap['frequencyMetric'] as String,
      frequency: jsonMap['frequency'] as int,
      actionTime: jsonMap['actionTime'] as String,
      criticality: jsonMap['criticality'] as String,
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
      recommendationStepsVO: (jsonMap['recommendationStepsVO'] != null)
          ? (jsonMap['recommendationStepsVO'] as List)
              .map(
                (step) => RecommendationStepModel.fromJson(
                  step as Map<String, dynamic>,
                ),
              )
              .toList()
          : (jsonMap['recommendationSteps'] != null)
              ? (jsonMap['recommendationSteps'] as List)
                  .map(
                    (step) => RecommendationStepModel.fromJson(
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
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "subtitle": subtitle,
      "iconVO": null,
      "durationInMinutes": durationInMinutes,
      "messageOnReceivingFeedback": messageOnReceivingFeedback,
      "messageOnCompletion": messageOnCompletion,
      "recommendationStatus": recommendationStatus,
      "frequencyMetric": frequencyMetric,
      "frequency": frequency,
      "actionTime": actionTime,
      "criticality": criticality,
      "categoryVO": (categoryVO as RecommendationStepModel).toJson(),
      "recommendationStepsVO": recommendationStepsVO
          .map(
            (step) => (step as RecommendationStepModel).toJson(),
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
