// Flutter imports:

// Project imports:
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation.dart';
import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';

import 'activity-model.dart';

class RecommendationModel extends DataModel<Recommendation> {
  ActivityModel activity;
  double weight;

  RecommendationModel.fromJson(Map<String, dynamic> jsonMap)
      : activity = ActivityModel.fromJson(
          jsonMap['recommendation'] as Map<String, dynamic>,
        ),
        weight = (jsonMap['weight'] as num).toDouble();

  RecommendationModel.fromDomain(Recommendation recommendation)
      : activity = ActivityModel.fromDomain(recommendation.activity),
        weight = recommendation.weight;

  @override
  Map<String, dynamic> toJson() {
    return {
      "activity": activity.toJson(),
      "weight": weight,
    };
  }

  @override
  Recommendation toDomain() {
    return Recommendation(
      activity: activity.toDomain(),
      weight: weight,
    );
  }
}
