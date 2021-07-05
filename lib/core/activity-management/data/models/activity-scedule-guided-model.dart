// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../domain/entities/activity-schedule-guided.dart';
import 'guided-activity-recommendation-model.dart';
import 'path-information-model.dart';
import 'tag-model.dart';

class ActivityScheduleGuidedModel extends ActivitySceduleGuided {
  const ActivityScheduleGuidedModel({
    required int? id,
    required PathInformationModel pathInformation,
    required List<GuidedActivityRecommendationModel> activitySchedule,
    required List<TagModel> tags,
  }) : super(
          tags: tags,
          pathInformation: pathInformation,
          activitySchedule: activitySchedule,
          id: id,
        );

  factory ActivityScheduleGuidedModel.fromJson(Map<String, dynamic> jsonMap) {
    return ActivityScheduleGuidedModel(
      id: jsonMap['id'] as int?,
      pathInformation: PathInformationModel.fromJson(
        jsonMap['pathInformation'] as Map<String, dynamic>,
      ),
      activitySchedule: (jsonMap['activitySchedule'] as List)
          .map(
            (recommendation) => GuidedActivityRecommendationModel.fromJson(
              recommendation as Map<String, dynamic>,
            ),
          )
          .toList(),
      tags: (jsonMap['tags'] as List)
          .map(
            (tag) => TagModel.fromJson(
              tag as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}
