// Flutter imports:

// Project imports:
import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';

import '../../domain/entities/activity-schedule-guided.dart';
import 'guided-activity-recommendation-model.dart';
import 'path-information-model.dart';
import 'tag-model.dart';

class ActivityScheduleGuidedModel extends DataModel<ActivitySceduleGuided> {
  int? id;
  PathInformationModel? pathInformation;
  List<GuidedActivityRecommendationModel>? activitySchedule;
  List<TagModel>? tags;

  ActivityScheduleGuidedModel.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] as int?,
        pathInformation = PathInformationModel.fromJson(
            jsonMap['pathInformation'] as Map<String, dynamic>),
        activitySchedule = (jsonMap['activitySchedule'] as List)
            .map(
              (recommendation) => GuidedActivityRecommendationModel.fromJson(
                  recommendation as Map<String, dynamic>),
            )
            .toList(),
        tags = (jsonMap['tags'] as List)
            .map(
              (tag) => TagModel.fromJson(tag as Map<String, dynamic>),
            )
            .toList();

  @override
  ActivitySceduleGuided toDomain() {
    return ActivitySceduleGuided(
      id: id,
      pathInformation: pathInformation!.toDomain(),
      activitySchedule:
          activitySchedule!.map((activity) => activity.toDomain()).toList(),
      tags: tags!.map((tag) => tag.toDomain()).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO= implement toJson
    throw UnimplementedError();
  }
}
