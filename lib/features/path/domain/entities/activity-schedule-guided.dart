import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:tatsam_app_experimental/features/path/domain/entities/guided-activity-recommendation.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/path-information-guided.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/tag.dart';

class ActivitySceduleGuided extends Equatable {
  final int id;
  final PathInformation pathInformation;
  final List<GuidedActivityRecommendation> activitySchedule;
  final List<Tag> tags;
  const ActivitySceduleGuided({
    @required this.id,
    @required this.pathInformation,
    @required this.activitySchedule,
    @required this.tags,
  });
  @override
  List<Object> get props => [id, pathInformation, activitySchedule, tags];

  @override
  bool get stringify => true;
}
