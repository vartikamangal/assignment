// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation.dart';
import 'recommendation-activity-model.dart';

class RecommendationModel extends Recommendation {
  const RecommendationModel({
    @required ActivityRecommendationModel activity,
    @required double weight,
  }) : super(
          activity: activity,
          weight: weight,
        );

  factory RecommendationModel.fromJson(Map<String, dynamic> jsonMap) {
    return RecommendationModel(
      activity: ActivityRecommendationModel.fromJson(
        jsonMap['recommendation'] as Map<String, dynamic>,
      ),
      weight: (jsonMap['weight'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "activity": (activity as ActivityRecommendationModel).toJson(),
      "weight": weight,
    };
  }
}
