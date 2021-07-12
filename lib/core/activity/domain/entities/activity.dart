// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../image/image.dart';
import '../../../perform-activity/domain/entities/activity-step.dart';
import 'recommendation-category.dart';
import 'tag.dart';

class Activity extends Equatable {
  final String? id;
  final String? title;
  final String? subtitle;
  final ImageProp? iconVO;
  final int? durationInMinutes;
  final String? messageOnReceivingFeedback;
  final String? messageOnCompletion;
  final String? recommendationStatus;
  final String? frequencyMetric;
  final int? frequency;
  final String? actionTime;
  final String? criticality; //creation time //tags are not sametype
  final RecommendationCategory? categoryVO; //Modify
  final List<ActivityStep>? activitySteps; // Modify List<T>
  final List<Tag> tags; // Modify List<T>
  const Activity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconVO,
    required this.durationInMinutes,
    required this.messageOnReceivingFeedback,
    required this.messageOnCompletion,
    required this.recommendationStatus,
    required this.frequencyMetric,
    required this.frequency,
    required this.actionTime,
    required this.criticality,
    required this.categoryVO,
    required this.activitySteps,
    required this.tags,
  });
  @override
  List<Object?> get props {
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
      activitySteps,
      tags,
    ];
  }

  @override
  bool get stringify => true;

  Activity copyWith({
    String? id,
    String? title,
    String? subtitle,
    ImageProp? iconVO,
    int? durationInMinutes,
    String? messageOnReceivingFeedback,
    String? messageOnCompletion,
    String? recommendationStatus,
    String? frequencyMetric,
    int? frequency,
    String? actionTime,
    String? criticality,
    RecommendationCategory? categoryVO,
    List<ActivityStep>? activitySteps,
    List<Tag>? tags,
  }) {
    return Activity(
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
      activitySteps: activitySteps ?? this.activitySteps,
      tags: tags ?? this.tags,
    );
  }
}
