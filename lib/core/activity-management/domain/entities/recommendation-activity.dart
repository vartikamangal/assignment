// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/image/image.dart';
import 'recommendation-category.dart';
import 'recommendation-step.dart';
import 'tag.dart';

class ActivityRecommendation extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final ImageProp iconVO;
  final int durationInMinutes;
  final String messageOnReceivingFeedback;
  final String messageOnCompletion;
  final String recommendationStatus;
  final String frequencyMetric;
  final int frequency;
  final String actionTime;
  final String criticality;
  final RecommendationCategory categoryVO; //Modify
  final List<RecommendationStep> recommendationStepsVO; // Modify List<T>
  final List<Tag> tags; // Modify List<T>
  const ActivityRecommendation({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    @required this.iconVO,
    @required this.durationInMinutes,
    @required this.messageOnReceivingFeedback,
    @required this.messageOnCompletion,
    @required this.recommendationStatus,
    @required this.frequencyMetric,
    @required this.frequency,
    @required this.actionTime,
    @required this.criticality,
    @required this.categoryVO,
    @required this.recommendationStepsVO,
    @required this.tags,
  });
  @override
  List<Object> get props {
    return [
      id,
      title,
      subtitle,
      iconVO,
      durationInMinutes,
      messageOnReceivingFeedback,
      messageOnCompletion,
      recommendationStatus,
      frequencyMetric,
      frequency,
      actionTime,
      criticality,
      categoryVO,
      recommendationStepsVO,
      tags,
    ];
  }

  @override
  bool get stringify => true;

  ActivityRecommendation copyWith({
    String id,
    String title,
    String subtitle,
    ImageProp iconVO,
    int durationInMinutes,
    String messageOnReceivingFeedback,
    String messageOnCompletion,
    String recommendationStatus,
    String frequencyMetric,
    int frequency,
    String actionTime,
    String criticality,
    RecommendationCategory categoryVO,
    List<RecommendationStep> recommendationStepsVO,
    List<Tag> tags,
  }) {
    return ActivityRecommendation(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      iconVO: iconVO ?? this.iconVO,
      durationInMinutes: durationInMinutes ?? this.durationInMinutes,
      messageOnReceivingFeedback:
          messageOnReceivingFeedback ?? this.messageOnReceivingFeedback,
      messageOnCompletion: messageOnCompletion ?? this.messageOnCompletion,
      recommendationStatus: recommendationStatus ?? this.recommendationStatus,
      frequencyMetric: frequencyMetric ?? this.frequencyMetric,
      frequency: frequency ?? this.frequency,
      actionTime: actionTime ?? this.actionTime,
      criticality: criticality ?? this.criticality,
      categoryVO: categoryVO ?? this.categoryVO,
      recommendationStepsVO:
          recommendationStepsVO ?? this.recommendationStepsVO,
      tags: tags ?? this.tags,
    );
  }
}
