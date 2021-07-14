// Flutter imports:
// Package imports:
import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';

// Project imports:
import 'guided-activity-recommendation.dart';
import 'path-information-guided.dart';
import 'tag.dart';

class ActivitySceduleGuided extends Entity {
  final int? id;
  final PathInformation pathInformation;
  final List<GuidedActivityRecommendation> activitySchedule;
  final List<Tag> tags;

  ActivitySceduleGuided({
    required this.id,
    required this.pathInformation,
    required this.activitySchedule,
    required this.tags,
  });

  ActivitySceduleGuided copyWith({
    int? id,
    PathInformation? pathInformation,
    List<GuidedActivityRecommendation>? activitySchedule,
    List<Tag>? tags,
  }) {
    return ActivitySceduleGuided(
      id: id ?? this.id,
      pathInformation: pathInformation ?? this.pathInformation,
      activitySchedule: activitySchedule ?? this.activitySchedule,
      tags: tags ?? this.tags,
    );
  }

  @override
  String toString() {
    return 'ActivitySceduleGuided(id: $id, pathInformation: $pathInformation, activitySchedule: $activitySchedule, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ActivitySceduleGuided &&
        other.id == id &&
        other.pathInformation == pathInformation &&
        listEquals(other.activitySchedule, activitySchedule) &&
        listEquals(other.tags, tags);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pathInformation.hashCode ^
        activitySchedule.hashCode ^
        tags.hashCode;
  }
}
