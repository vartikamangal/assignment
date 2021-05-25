import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/features/path/data/models/guided-activity-recommendation-model.dart';
import 'package:tatsam_app_experimental/features/path/data/models/path-information-model.dart';
import 'package:tatsam_app_experimental/features/path/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/activity-schedule-guided.dart';

class ActivityScheduleGuidedModel extends ActivitySceduleGuided {
  const ActivityScheduleGuidedModel({
    @required int id,
    @required PathInformationModel pathInformation,
    @required List<GuidedActivityRecommendationModel> activitySchedule,
    @required List<TagModel> tags,
  }) : super(
          tags: tags,
          pathInformation: pathInformation,
          activitySchedule: activitySchedule,
          id: id,
        );

  factory ActivityScheduleGuidedModel.fromJson(Map<String, dynamic> jsonMap) {
    return ActivityScheduleGuidedModel(
      id: jsonMap['id'] as int,
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
