// Flutter imports:
// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'guided-activity-recommendation.dart';
import 'path-information-guided.dart';
import 'tag.dart';

class ActivitySceduleGuided extends Equatable {
  final int? id;
  final PathInformation pathInformation;
  final List<GuidedActivityRecommendation> activitySchedule;
  final List<Tag> tags;
  const ActivitySceduleGuided({
    required this.id,
    required this.pathInformation,
    required this.activitySchedule,
    required this.tags,
  });
  @override
  List<Object?> get props => [id, pathInformation, activitySchedule, tags];

  @override
  bool get stringify => true;
}
