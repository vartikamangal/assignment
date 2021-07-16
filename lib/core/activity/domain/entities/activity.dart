// Package imports:
import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';

// Project imports:
import '../../../image/image.dart';
import '../../../perform-activity/domain/entities/activity-step.dart';
import 'recommendation-category.dart';
import 'tag.dart';

class Activity extends Entity {
  final String? id;
  final String? title;
  final String? subtitle;
  final ImageEntity? iconVO;
  final int? durationInMinutes;
  final String? messageOnReceivingFeedback;
  final String? messageOnCompletion;
  final String? recommendationStatus;
  final String? frequencyMetric;
  final int? frequency;
  final String? actionTime;
  final String? criticality; //creation time //tags are not sametype
  final RecommendationCategory? categoryVO; //Modify
  final List<ActivityStep> _activitySteps; // Modify List<T>
  final List<Tag> tags; // Modify List<T>

  Activity({
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
    required List<ActivityStep> activitySteps,
    required this.tags,
  }) : _activitySteps = activitySteps;

  @override
  String toString() {
    return 'PActivity(id: $id, title: $title, subtitle: $subtitle, iconVO: $iconVO, durationInMinutes: $durationInMinutes, messageOnReceivingFeedback: $messageOnReceivingFeedback, messageOnCompletion: $messageOnCompletion, recommendationStatus: $recommendationStatus, frequencyMetric: $frequencyMetric, frequency: $frequency, actionTime: $actionTime, criticality: $criticality, categoryVO: $categoryVO, activitySteps: $_activitySteps, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Activity &&
        other.id == id &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.iconVO == iconVO &&
        other.durationInMinutes == durationInMinutes &&
        other.messageOnReceivingFeedback == messageOnReceivingFeedback &&
        other.messageOnCompletion == messageOnCompletion &&
        other.recommendationStatus == recommendationStatus &&
        other.frequencyMetric == frequencyMetric &&
        other.frequency == frequency &&
        other.actionTime == actionTime &&
        other.criticality == criticality &&
        other.categoryVO == categoryVO &&
        listEquals(other.activitySteps, activitySteps) &&
        listEquals(other.tags, tags);
  }

  List<ActivityStep> get activitySteps {
    _activitySteps.sort((a, b) => a.stepSequence!.compareTo(b.stepSequence!));
    return _activitySteps;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        iconVO.hashCode ^
        durationInMinutes.hashCode ^
        messageOnReceivingFeedback.hashCode ^
        messageOnCompletion.hashCode ^
        recommendationStatus.hashCode ^
        frequencyMetric.hashCode ^
        frequency.hashCode ^
        actionTime.hashCode ^
        criticality.hashCode ^
        categoryVO.hashCode ^
        activitySteps.hashCode ^
        tags.hashCode;
  }
}
